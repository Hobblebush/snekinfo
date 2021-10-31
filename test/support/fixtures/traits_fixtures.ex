defmodule Snekinfo.TraitsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Traits` context.
  """

  @doc """
  Generate a trait.
  """
  def trait_fixture(attrs \\ %{}) do
    {:ok, trait} =
      attrs
      |> Enum.into(%{
        inheritance: "poly",
        name: "wings"
      })
      |> Snekinfo.Traits.create_trait()

    trait
  end
end
