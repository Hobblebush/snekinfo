defmodule Snekinfo.Weights.Weight do
  use Ecto.Schema
  import Ecto.Changeset

  schema "weights" do
    field :timestamp, :utc_datetime
    field :weight, :float
    field :snake_id, :id

    timestamps()
  end

  @doc false
  def changeset(weight, attrs) do
    weight
    |> cast(attrs, [:weight, :timestamp])
    |> validate_required([:weight, :timestamp])
  end
end
