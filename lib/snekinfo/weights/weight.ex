defmodule Snekinfo.Weights.Weight do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snekinfo.Snakes.Snake

  schema "weights" do
    field :date, :date
    field :weight, :float
    belongs_to :snake, Snake

    timestamps()
  end

  @doc false
  def changeset(weight, attrs) do
    weight
    |> cast(attrs, [:snake_id, :weight, :date])
    |> validate_required([:snake_id, :weight, :date])
    |> validate_number(:weight, greater_than: 0.0)
  end
end
