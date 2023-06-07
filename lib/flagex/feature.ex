defmodule Flagex.Feature do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Flagex.Repo

  @permitted_params ~w(enabled name description)a

  @required_params ~w(name description)a

  @type t() :: %__MODULE__{}

  schema "flagex_features" do
    field(:enabled, :boolean, default: false)
    field(:name, :string)
    field(:description, :string)

    timestamps()
  end

  defp new(args) do
    %__MODULE__{}
    |> cast(args, @permitted_params)
    |> validate_required(@required_params)
    |> validate_length(:name, mix: 3, max: 128)
    |> validate_length(:description, mix: 10, max: 128)
  end

  defp update(feature, args) do
    feature
    |> cast(args, @permitted_params)
    |> validate_length(:name, mix: 3, max: 128)
    |> validate_length(:description, mix: 10, max: 128)
  end

  ## Public API
  def insert_disabled!(name, description) do
    %{name: name, description: description}
    |> new()
    |> Repo.insert!()
  end

  def enable!(name) do
    __MODULE__
    |> Repo.get_by(name: name)
    |> update(%{enabled: true})
    |> Repo.update!()
  end

  def disable!(name) do
    __MODULE__
    |> Repo.get_by(name: name)
    |> update(%{enabled: false})
    |> Repo.update!()
  end

  def enabled?(name) do
    query =
      from(ft in __MODULE__,
        where: ft.name == ^name,
        where: ft.enabled
      )

    Repo.exists?(query)
  end
end
