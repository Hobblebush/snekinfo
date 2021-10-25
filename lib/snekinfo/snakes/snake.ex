defmodule Snekinfo.Snakes.Snake do
  use Ecto.Schema
  import Ecto.Changeset

  schema "snakes" do
    field :born, :date
    field :name, :string
    field :sex, :string
    field :litter_id, :id

    timestamps()
  end

  @doc false
  def changeset(snake, attrs) do
    snake
    |> cast(attrs, [:name, :sex, :born])
    |> validate_required([:name, :sex, :born])
  end
end
