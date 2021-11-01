defmodule Snekinfo.WeightsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Weights` context.
  """

  alias Snekinfo.SnakesFixtures

  @doc """
  Generate a weight.
  """
  def weight_fixture(attrs \\ %{}) do
    snake = SnakesFixtures.snake_fixture()

    {:ok, weight} =
      attrs
      |> Enum.into(%{
        snake_id: snake.id,
        date: ~D[2021-10-20],
        weight: 120.5
      })
      |> Snekinfo.Weights.create_weight()

    weight
  end
end
