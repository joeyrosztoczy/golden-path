defmodule Mix.Tasks.VerifyBuild do
  @moduledoc """
  Run's our build verification suite concurrently, and locally, to test before hitting CI Server.
  """

  use Mix.Task

  # Thanks for task timeout dialyzer
  @task_timeout 120_000
  @ci_tasks [:credo, :dialyzer, :tests]

  @shortdoc "Runs tests, Credo, and Dialyzer."

  def run(_) do
    @ci_tasks
    |> Enum.map(fn task -> Task.async(fn -> run_check(task) end) end)
    |> Enum.map(fn pid -> Task.await(pid, @task_timeout) end)
  end

  def run_check(:credo) do
    IO.puts("Running task: mix credo")

    case System.cmd("mix", ["credo"]) do
      {_, 0} ->
        print_status("Credo", :success)

      {out, _} ->
        print_status("Credo", :failure, out)
    end
  end

  def run_check(:dialyzer) do
    IO.puts("Running task: mix dialyzer --halt-exit-status")

    case System.cmd("mix", ["dialyzer", "--halt-exit-status"]) do
      {_, 0} ->
        print_status("Dialyzer", :success)

      {out, _} ->
        print_status("Dialyzer", :failure, out)
    end
  end

  def run_check(:tests) do
    IO.puts("Running task: mix coveralls")

    case System.cmd("mix", ["coveralls"]) do
      {out, 0} ->
        print_status("Tests", :success, out)

      {out, _} ->
        print_status("Tests", :failure, out)
    end
  end

  defp print_status(task, status, msg \\ "")

  defp print_status(task, :success, _) do
    [:blue, :bright, "#{task} finished: ", :green, :bright, "Everything looks great!"]
    |> IO.ANSI.format()
    |> IO.puts()

    :ok
  end

  defp print_status(task, _status, msg) do
    [:blue, :bright, "#{task} finished: \n", :red, :bright, "#{msg}"]
    |> IO.ANSI.format()
    |> IO.puts()

    :error
  end
end
