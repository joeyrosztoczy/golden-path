[![CircleCI](https://circleci.com/gh/joeyrosztoczy/golden-path.svg?style=shield)](https://circleci.com/gh/joeyrosztoczy/golden-path)

Note: If somethings not working, you get stuck, etc feel free to file an issue or even better a PR ^^. I won't be super timely because in crunch time on a few projects through March, but will periodically check it out! Cheers <3

# Tutorial on DevOps for Denver Elixir Meetup

### Talk covers weeks of content in 30 minutes, so we'll introduce practical abstractions where needed to build an entire devOps/CI/CD Pipeline.

These abstractions and tool choices provide a fully-functional pipeline, but also allow an engineer to deep dive into whatever particular area of the pipeline they're more interested in, without losing benefits of the full integration.

1. To Abstract Releases: Distillery
2. Build Verification Tools: Compiler, Credo, Dialyzer, ExUnit + Coveralls
3. CI Server: Hosted CircleCI Free Tier
4. Cloud Management + Machines: Gigalixir Free Tier + Libcluster
5. If time, talk hot code swaps or more real distribution!
6. Worth talking about environment replication, too app specific to template though.

### If you just want a release-ready template that can be remotely deployed to Gigalixir as is, do this:

1. Clone the project `$ git clone https://github.com/joeyrosztoczy/golden-path.git`
2. `$ cd golden-path`
3. The final setup is the current master branch

Test your project / dev server before things get wild:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`
  
4. Manually verify the build with ```$ mix verify_build```
5. Setup a free CircleCI account: https://circleci.com/docs/2.0/first-steps/#section=getting-started
6. Setup a free Gigalixir account: https://gigalixir.readthedocs.io/en/latest/main.html#getting-started-guide
7. Create the Gigalixir App: https://gigalixir.readthedocs.io/en/latest/main.html#how-to-create-an-app
8. Create a free Postgresql db: https://gigalixir.readthedocs.io/en/latest/main.html#how-to-provision-a-free-postgresql-database
9. Deploy your app via the gigalixir remote with ```$ git push gigalixir master```
10. Verify the deployment with ```$ gigalixir logs -a golden-path```
11. Assuming you've added SSH keys, kick off Observer with ```$ gigalixir ps:observer -a golden-path``` (and select the remote node to inspect).

### If you want to follow along or build it out step by step, do this:

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

5. To see the build verifcation task and updates, review this PR: https://github.com/joeyrosztoczy/golden-path/pull/3

6. To see the configuration for CircleCI, and be able to launch a project there, review: https://github.com/joeyrosztoczy/golden-path/pull/4

7. To launch a remote deployment via Gigalixir, and use cluster-based tools like Observer, review: https://github.com/joeyrosztoczy/golden-path/pull/5


