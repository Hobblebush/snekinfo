defmodule Snekinfo.Traits.Trait do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snekinfo.Snakes.Snake

  schema "traits" do
    field :inheritance, :string
    field :name, :string

    many_to_many :snakes, Snake, join_through: "snake_traits"

    timestamps()
  end

  def inheritances do
    ["∅", "dominant", "recessive", "poly"]
  end

  @doc false
  def changeset(trait, attrs) do
    trait
    |> cast(attrs, [:name, :inheritance])
    |> validate_required([:name, :inheritance])
    |> validate_inclusion(:inheritance, inheritances())
    |> unique_constraint(:name)
  end
end
