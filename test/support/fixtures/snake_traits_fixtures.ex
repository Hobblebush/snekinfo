defmodule Snekinfo.Snake_traitsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Snake_traits` context.
  """

  @doc """
  Generate a snake_trait.
  """
  def snake_trait_fixture(attrs \\ %{}) do
    {:ok, snake_trait} =
      attrs
      |> Enum.into(%{

      })
      |> Snekinfo.Snake_traits.create_snake_trait()

    snake_trait
  end
end
