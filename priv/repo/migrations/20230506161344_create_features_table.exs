defmodule Flagex.Repo.Migrations.CreateFeaturesTable do
  use Ecto.Migration

  def up do
    create table("flagex_features") do
      add :enabled, :boolean
      add :name, :string
      add :description, :string

      timestamps()
    end
  end

  def down do
    drop table("flagex_features")
  end
end
