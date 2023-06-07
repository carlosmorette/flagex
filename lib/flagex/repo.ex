defmodule Flagex.Repo do
  use Ecto.Repo,
    otp_app: :flagex,
    adapter: Ecto.Adapters.SQLite3
end
