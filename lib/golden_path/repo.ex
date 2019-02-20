defmodule GoldenPath.Repo do
  use Ecto.Repo,
    otp_app: :golden_path,
    adapter: Ecto.Adapters.Postgres
end
