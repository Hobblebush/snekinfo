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
        inheritance: "some inheritance",
        name: "some name"
      })
      |> Snekinfo.Traits.create_trait()

    trait
  end
end
