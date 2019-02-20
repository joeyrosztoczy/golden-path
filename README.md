# Tutorial on DevOps for Denver Elixir Meetup

### Tutorial needs to cover weeks of content in 30 minutes, so we lean on:

1. Releases (Distillery)
2. Build Verification (Credo, Dialyzer, Tests, etc)
3. CI/CD (CircleCI Free Tier)
4. Remote Deployment Tools (Libcluster + Gigalixir Free Tier)
5. If time, talk hot code swaps and more real distribution! (Maybe just demoing hot code is cooler idk)

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

// Update config/prod.exs, compile with PROD, build static assets (node run deploy, mix phx.digest), create PROD release

// Create proddb, run release with PROD in foreground to test

// Explain runtime vs buildtime configuration etc!

5. We're now at branch `s2-that-release-tho`. We can build a release that is a self-contained artifact of our entire phoenix application.

// Next Branch Stops:

I. How do we know build is good: Configure Credo, Dialyzer, Tests, CI Server, MIX CI Task
II. Want to get build out: Deploy task to ship to gigalixir free tier & demo on remote server
III. Use the battle tank: Add libcluster to punch through k8s in Gigalixir, and demo remote observer (this also essentially coveres non-behavioral aspects of distribution kind of and at speed, may need to highlight how this works)
IV.
