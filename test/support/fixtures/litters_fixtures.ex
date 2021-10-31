defmodule Snekinfo.LittersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Litters` context.
  """

  alias Snekinfo.SnakesFixtures

  @doc """
  Generate a litter.
  """
  def litter_fixture(attrs \\ %{}) do
    mother = SnakesFixtures.snake_fixture()

    {:ok, litter} =
      attrs
      |> Enum.into(%{
        mother_id: mother.id,
        born: ~D[2021-10-20]
      })
      |> Snekinfo.Litters.create_litter()

    litter
  end
end
