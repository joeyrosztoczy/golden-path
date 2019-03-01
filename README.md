[![CircleCI](https://circleci.com/gh/joeyrosztoczy/golden-path.svg?style=shield)](https://circleci.com/gh/joeyrosztoczy/golden-path)

# Tutorial on DevOps for Denver Elixir Meetup

### Talk covers weeks of content in 30 minutes, so we'll introduce practical abstractions where needed to build an entire devOps/CI/CD Pipeline.

These abstractions and tool choices provide a fully-functional pipeline, but also allow an engineer to deep dive into whatever particular area of the pipeline they're more interested in, without losing benefits of the full integration.

1. To Abstract Releases: Distillery
2. Build Verification Tools: Compiler, Credo, Dialyzer, ExUnit + Coveralls
3. CI Server: Hosted CircleCI Free Tier
4. Cloud Management + Machines: Gigalixir Free Tier + Libcluster
5. If time, talk hot code swaps or more real distribution!
6. Worth talking about environment replication, too app specific to template though.

(Maybe just demoing hot code is cooler idk, could spin up a GenServer that does some cool thing on a timer and hot code swap without losing state and with no disk persistance)

(Con on distribution is really with Erlang VM its just a bit of config and piping through networking, the harder part is software behavior and design i.e. are there distribution not-friendly-features etc, and that's way to big to do more that give lip service too).

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

I. Review Build Verification
https://github.com/joeyrosztoczy/golden-path/pull/3
II. Review Continuous Integration Server
https://github.com/joeyrosztoczy/golden-path/pull/4
II. Want to get build out: Deploy task to ship to gigalixir free tier & demo on remote server
III. Use the battle tank: Add libcluster to punch through k8s in Gigalixir, and demo remote observer (this also essentially coveres non-behavioral aspects of distribution kind of and at speed, may need to highlight how this works)
IV.
