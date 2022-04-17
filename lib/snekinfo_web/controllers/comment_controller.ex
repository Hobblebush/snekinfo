defmodule SnekinfoWeb.CommentController do
  use SnekinfoWeb, :controller

  alias Snekinfo.Comments
  alias Snekinfo.Comments.Comment
  alias Snekinfo.Snakes

  def new(conn, %{"snake_id" => snake_id}) do
    snake = Snakes.get_snake!(snake_id)
    changeset = Comments.change_comment(%Comment{})
    render(conn, "new.html", changeset: changeset, snake: snake)
  end

  def create(conn, %{"snake_id" => snake_id, "comment" => comment_params}) do
    snake = Snakes.get_snake!(snake_id)
    comment_params = comment_params
    |> Map.put("snake_id", snake.id)
    |> Map.put("user_id", conn.assigns[:current_user].id)

    case Comments.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.snake_path(conn, :show, snake))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, snake: snake)
    end
  end
end
