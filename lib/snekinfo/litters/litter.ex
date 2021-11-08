defmodule Snekinfo.Litters.Litter do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snekinfo.Snakes.Snake

  schema "litters" do
    field :born, :date
    field :slugs, :integer
    field :stills, :integer

    belongs_to :mother, Snake
    belongs_to :father, Snake
    has_many :snakes, Snake

    field :size, :integer, virtual: true
    field :mf_ratio, :float, virtual: true

    timestamps()
  end

  @doc false
  def changeset(litter, attrs) do
    litter
    |> cast(attrs, [:mother_id, :father_id, :born, :slugs, :stills])
    |> validate_required([:mother_id, :born, :slugs, :stills])
  end
end
