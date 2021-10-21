defmodule Snekinfo.LittersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Litters` context.
  """

  @doc """
  Generate a litter.
  """
  def litter_fixture(attrs \\ %{}) do
    {:ok, litter} =
      attrs
      |> Enum.into(%{
        born: ~D[2021-10-20]
      })
      |> Snekinfo.Litters.create_litter()

    litter
  end
end
