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
        name: "some name",
        sex: "some sex"
      })
      |> Snekinfo.Snakes.create_snake()

    snake
  end

  @doc """
  Generate a snake.
  """
  def snake_fixture(attrs \\ %{}) do
    {:ok, snake} =
      attrs
      |> Enum.into(%{
        born: ~D[2021-10-20],
        name: "some name",
        sex: "some sex"
      })
      |> Snekinfo.Snakes.create_snake()

    snake
  end
end
