defmodule Snekinfo.Litters.Litter do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snekinfo.Snakes.Snake

  schema "litters" do
    field :born, :date
    belongs_to :mother, Snake
    belongs_to :father, Snake
    has_many :snakes, Snake

    field :size, :integer, virtual: true

    timestamps()
  end

  @doc false
  def changeset(litter, attrs) do
    litter
    |> cast(attrs, [:born])
    |> validate_required([:born])
  end
end
