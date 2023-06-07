import Config

config :flagex, :ecto_repos, [Flagex.Repo]

config :flagex, Flagex.Repo, database: "priv/database.db"
