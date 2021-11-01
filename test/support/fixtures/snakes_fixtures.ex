defmodule Snekinfo.SnakesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Snakes` context.
  """

  @doc """
  Generate a snake.
  """
  def snake_fixture(attrs \\ %{}) do
    {:ok, snake} =
      attrs
      |> Enum.into(%{
        born: ~D[2018-10-20],
        name: "Alex",
        sex: "F",
        traits: [],
      })
      |> Snekinfo.Snakes.create_snake()

    snake
  end
end
