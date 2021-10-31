defmodule Snekinfo.Snakes.Snake do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snekinfo.Litters.Litter
  alias Snekinfo.Traits.Trait

  schema "snakes" do
    field :born, :date
    field :name, :string
    field :sex, :string
    belongs_to :litter, Litter

    many_to_many :traits, Trait, join_through: "snake_traits"

    timestamps()
  end

  def sexes do
    [nil, "F", "M"]
  end

  @doc false
  def changeset(snake, attrs) do
    snake
    |> cast(attrs, [:litter_id, :name, :sex, :born])
    |> put_assoc(:traits, attrs["traits"])
    |> validate_required([:name, :sex, :born])
    |> validate_inclusion(:sex, sexes())
  end
end
