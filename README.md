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
