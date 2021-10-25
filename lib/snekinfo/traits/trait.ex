defmodule Snekinfo.Traits.Trait do
  use Ecto.Schema
  import Ecto.Changeset

  schema "traits" do
    field :inheritance, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(trait, attrs) do
    trait
    |> cast(attrs, [:name, :inheritance])
    |> validate_required([:name, :inheritance])
  end
end
