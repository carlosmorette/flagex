defmodule Flagex do
  alias Flagex.Feature

  def feature_enabled?(name) do
    Feature.enabled?(name)
  end

  def insert_feature!(name, description) do
    Feature.insert_disabled!(name, description)
  end

  def enable_feature!(name) do
    Feature.enable!(name)
  end

  def disable_feature!(name) do
    Feature.disable!(name)
  end
end
