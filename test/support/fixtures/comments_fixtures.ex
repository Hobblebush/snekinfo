defmodule Snekinfo.CommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Snekinfo.Comments` context.
  """

  alias Snekinfo.Comments.Comment

  import Snekinfo.UsersFixtures
  import Snekinfo.SnakesFixtures

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    user = user_fixture()
    snake = snake_fixture()

    {:ok, comment} =
      attrs
      |> Enum.into(%{
        user_id: user.id,
        snake_id: snake.id,
        approved?: false,
        body: "some body"
      })
      |> Snekinfo.Comments.create_comment()

    %Comment{ comment | approved?: false }
  end
end
