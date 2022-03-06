defmodule Snekinfo.ShedsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Sheds` context.
  """

  import Snekinfo.SnakesFixtures

  @doc """
  Generate a shed.
  """
  def shed_fixture(attrs \\ %{}) do
    snake = snake_fixture()

    {:ok, shed} =
      attrs
      |> Enum.into(%{
        snake_id: snake.id,
        date: ~D[2022-02-27]
      })
      |> Snekinfo.Sheds.create_shed()

    shed
  end
end
