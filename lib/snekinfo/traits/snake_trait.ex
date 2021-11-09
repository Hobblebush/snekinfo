defmodule Snekinfo.Traits.SnakeTrait do
  use Ecto.Schema
  import Ecto.Changeset

  alias Snekinfo.Snakes.Snake
  alias Snekinfo.Traits.Trait

  schema "snake_traits" do
    belongs_to :snake, Snake
    belongs_to :trait, Trait
  end
end
