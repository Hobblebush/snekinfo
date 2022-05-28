defmodule Snekinfo.SnakesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Snakes` context.
  """
  import Snekinfo.TaxaFixtures
  import Snekinfo.TraitsFixtures

  alias Snekinfo.Snakes.Snake

  @doc """
  Generate a snake.
  """
  def snake_fixture(attrs \\ %{}) do
    sp = species_fixture()
    t1 = trait_fixture()
    t2 = trait_fixture()

    traits = [t1, t2]

    {:ok, snake} =
      attrs
      |> Enum.into(%{
        born: ~D[2018-10-20],
        name: "Alex",
        sex: "F",
        traits: traits,
        status: "keep",
        species_id: sp.id,
      })
      |> Snekinfo.Snakes.create_snake()

    %Snake{ snake | traits: traits }
  end
end
