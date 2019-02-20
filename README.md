# Tutorial on DevOps for Denver Elixir Meetup

First steps:

1. Clone me `$ git clone https://github.com/joeyrosztoczy/golden-path.git`
2. `$ cd golden-path`
3. Start at the right spot `$ git checkout s1-starting-fresh`

Test your project / dev server before things get wild:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`
  
4. [Distillery](https://github.com/bitwalker/distillery) is going to help us perform the grunt work of building the Erlang Release. It's currently the only dependency added to the project.

     - First, run the Distillery provided command `$ mix release.init` from your project root. We're creating a `rel/` directory, and a `rel/config.exs` script. We'll use this directory to store such awesomeness as: (1) runtime configuration for our application, (2) configuration parameters for the Erlang VM, (3) commands that we can run remotely such as seeding, etc.

// Update config/prod.exs, export port, build static assets, create PROD release
