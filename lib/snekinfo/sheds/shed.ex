defmodule Snekinfo.Sheds.Shed do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snekinfo.Snakes.Snake

  schema "sheds" do
    field :date, :date
    belongs_to :snake, Snake

    timestamps()
  end

  @doc false
  def changeset(shed, attrs) do
    shed
    |> cast(attrs, [:date, :snake_id])
    |> validate_required([:date, :snake_id])
  end
end
