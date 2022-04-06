defmodule Snekinfo.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :approved?, :boolean, default: false
    field :body, :string
    belongs_to :user, Snekinfo.Users.User
    belongs_to :snake, Snekinfo.Snakes.Snake

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :user_id, :snake_id])
    |> validate_required([:body, :user_id, :snake_id])
  end
end
