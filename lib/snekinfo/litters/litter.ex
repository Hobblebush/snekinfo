defmodule Snekinfo.Litters.Litter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "litters" do
    field :born, :date
    field :mother_id, :id
    field :father_id, :id

    timestamps()
  end

  @doc false
  def changeset(litter, attrs) do
    litter
    |> cast(attrs, [:born])
    |> validate_required([:born])
  end
end
