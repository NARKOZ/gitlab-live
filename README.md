# GitLab Live

Interactive online shell for GitLab REST API, based on [gitlab client CLI](https://github.com/NARKOZ/gitlab).  
Can be used for administration tasks, as an interactive way to try out
GitLab API, or as a debugging aid during development.

Try it: https://gitlab-live.herokuapp.com

## Usage

Make sure to set the right credentials (`API endpoint` and `private token`) in
settings before executing commands.

```sh
# list groups
gitlab> groups

# list users
gitlab> users

# get current user
gitlab> user

# get a user
gitlab> user 2

# filter output
gitlab> user --only=id,username

# or
gitlab> user --except=email,bio

# protect a branch
gitlab> protect_branch 1 master

# pass options hash to a command (use YAML)
gitlab> create_merge_request 4 "New merge request" "{source_branch: 'new_branch', target_branch: 'master', assignee_id: 42}"
```

Also see http://narkoz.github.io/gitlab/cli

## Dev Installation

Clone the repository:

```sh
git clone https://github.com/NARKOZ/gitlab-live.git
cd gitlab-live
```

Install dependencies:

```sh
bundle install
```

Start the server:

```sh
rackup -p 3000
```

Open `localhost:3000`.

Run tests via `rake`.

## License

Released under the BSD 2-clause license. See LICENSE.txt for details.
