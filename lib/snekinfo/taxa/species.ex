defmodule Snekinfo.Taxa.Species do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snekinfo.Snakes.Snake
  alias Snekinfo.Traits.Trait

  schema "species" do
    field :name, :string

    has_many :snakes, Snake
    has_many :traits, Trait

    timestamps()
  end

  @doc false
  def changeset(species, attrs) do
    species
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
