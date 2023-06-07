defmodule Flagex do
  alias Flagex.Feature

  @spec feature_enabled?(String.t()) :: boolean()
  def feature_enabled?(name) do
    Feature.enabled?(name)
  end

  @spec insert_feature!(String.t(), String.t()) :: :ok
  def insert_feature!(name, description) do
    Feature.insert_disabled!(name, description)

    :ok
  end

  @spec enable_feature!(String.t()) :: :ok
  def enable_feature!(name) do
    Feature.enable!(name)

    :ok
  end

  @spec disable_feature!(String.t()) :: :ok
  def disable_feature!(name) do
    Feature.disable!(name)

    :ok
  end
end
