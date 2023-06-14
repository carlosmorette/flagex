defmodule Flagex.Feature do
  alias Flagex.Feature.Cache
  alias Flagex.Feature.Schema

  @spec enabled?(String.t()) :: boolean()
  def enabled?(name) do
    Cache.enable?(name)
  end

  @spec insert_feature!(String.t(), String.t()) :: :ok
  def insert_feature!(name, description) do
    Schema.insert_disabled!(name, description)

    :ok
  end

  @spec enable!(String.t()) :: :ok
  def enable!(name) do
    Schema.enable!(name)

    :ok
  end

  @spec disable!(String.t()) :: :ok
  def disable!(name) do
    Schema.disable!(name)

    :ok
  end
end
