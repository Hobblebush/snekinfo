defmodule Snekinfo.TaxaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Taxa` context.
  """

  alias Snekinfo.Taxa

  @doc """
  Generate a species.
  """
  def species_fixture(_attrs \\ %{}) do
    Taxa.get_or_create_species("Pigmy Alligator")
  end
end
