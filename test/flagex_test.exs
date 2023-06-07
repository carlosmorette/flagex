defmodule FlagexTest do
  use ExUnit.Case
  doctest Flagex

  test "greets the world" do
    assert Flagex.hello() == :world
  end
end
