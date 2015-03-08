require 'slim'
require 'gitlab/cli'
require 'sinatra/base'

class GitlabLive < Sinatra::Base
  Slim::Engine.set_options format: :html

  configure :development do
    Slim::Engine.set_options pretty: true

    require 'better_errors'
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__

    require 'sinatra/reloader'
    register Sinatra::Reloader
  end

  not_found do
    'Not found'
  end

  get '/' do
    @message = help_output
    slim :index
  end

  post '/query' do
    if params[:query].nil? || params[:token].nil? || params[:sudo].nil?
      halt 400, 'Missing parameter'
    end

    Gitlab.configure do |config|
      config.endpoint      = params[:host]
      config.private_token = params[:token].strip.empty? ? nil : params[:token]
      config.sudo          = params[:sudo].strip.empty? ? nil : params[:sudo]
      config.user_agent    = 'Gitlab-Live'
    end

    content_type :json

    banned_commands = %w(info shell -v --version)
    query = params[:query].split(' ')
    cmd = query.empty? ? '' : query.shift.strip

    if banned_commands.include? cmd
      result = help_output
    else
      result = capture_output { Gitlab::CLI.run cmd, query }
    end

    { query: params[:query], output: result }.to_json
  end

  def capture_output
    out = StringIO.new
    $stdout = out
    $stderr = out
    yield
    $stdout = STDOUT
    $stderr = STDERR
    out.string
  rescue SystemExit
    if out.string =~ /Unknown command/
      "Unknown command. #{help_output}"
    else
      out.string
    end
  end

  def help_output
    actions = Gitlab.actions.to_s.tr(':[]', '')
    "Available commands: #{actions}"
  end
end
