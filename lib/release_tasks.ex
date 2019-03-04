defmodule GoldenPath.ReleaseTasks do
  @moduledoc """
  Release tasks provide custom commands that can be triggered within the release environment via bin/goldenpath command.
  Early use cases are manual seeding, migrations, rollbacks etc of database from a deployed release.

  Release commands can also be attached to boothooks to automate some of these tasks.
  """
  @start_apps [
    :crypto,
    :ssl,
    :postgrex,
    :ecto
  ]

  @app :golden_path
  @repos Application.get_env(@app, :ecto_repos, [])

  def migrate do
    start_services()

    run_migrations()

    stop_services()
  end

  defp start_services do
    IO.puts("Loading #{@app}..")

    #  Load the code for myapp, but don't start it
    :ok = Application.load(@app)

    IO.puts("Starting dependencies..")
    # Start apps necessary for executing migrations
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    # Start the Repo(s) for app
    IO.puts("Starting repos..")
    Enum.each(@repos, & &1.start_link(pool_size: 1))
  end

  defp stop_services do
    IO.puts("Success stopping services!")
    :init.stop()
  end

  defp run_migrations do
    Enum.each(@repos, &run_migrations_for/1)
  end

  defp run_migrations_for(repo) do
    app = Keyword.get(repo.config, :otp_app)
    IO.puts("Running migrations for #{app}")
    migrations_path = priv_path_for(repo, "migrations")
    Ecto.Migrator.run(repo, migrations_path, :up, all: true)
  end

  defp priv_path_for(repo, filename) do
    app = Keyword.get(repo.config, :otp_app)

    repo_underscore =
      repo
      |> Module.split()
      |> List.last()
      |> Macro.underscore()

    priv_dir = "#{:code.priv_dir(app)}"

    Path.join([priv_dir, repo_underscore, filename])
  end
end
