ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'bundler'

Bundler.require :default, :test
require_relative '../app'

class GitlabLiveTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    GitlabLive
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
  end

  def test_index
    get '/'
    assert last_response.ok?
    assert last_response.body.include?('GitLab Live')
  end

  def test_query
    post '/query', { host: 'https://example.com/api/v4', token: '1234', sudo: '', query: 'help' }
    assert last_response.ok?
    assert last_response.content_type.include?('application/json')

    output   = capture_output { Gitlab::CLI.run('help') }
    expected = { query: 'help', output: output }.to_json
    assert_equal expected, last_response.body
  end
end
