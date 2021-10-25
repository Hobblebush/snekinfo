defmodule Snekinfo.Snake_traits.Snake_trait do
  use Ecto.Schema
  import Ecto.Changeset

  schema "snake_traits" do
    field :snake_id, :id
    field :trait_id, :id

    timestamps()
  end

  @doc false
  def changeset(snake_trait, attrs) do
    snake_trait
    |> cast(attrs, [])
    |> validate_required([])
  end
end
