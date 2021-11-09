defmodule Snekinfo.TaxaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Taxa` context.
  """

  @doc """
  Generate a species.
  """
  def species_fixture(attrs \\ %{}) do
    {:ok, species} =
      attrs
      |> Enum.into(%{
        name: "Pigmy Alligator"
      })
      |> Snekinfo.Taxa.create_species()

    species
  end
end
