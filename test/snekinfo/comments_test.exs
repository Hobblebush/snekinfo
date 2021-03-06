defmodule Snekinfo.CommentsTest do
  use Snekinfo.DataCase

  alias Snekinfo.Comments

  describe "comments" do
    alias Snekinfo.Comments.Comment

    import Snekinfo.CommentsFixtures
    import Snekinfo.SnakesFixtures
    import Snekinfo.UsersFixtures

    @invalid_attrs %{approved?: nil, body: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert_near_eq(Comments.list_comments(), [comment])
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      cc1 = Comments.get_comment!(comment.id)
      assert_near_eq(cc1, comment)
    end

    test "create_comment/1 with valid data creates a comment" do
      snake = snake_fixture()
      user = user_fixture()

      valid_attrs = %{
        snake_id: snake.id,
        user_id: user.id,
        approved?: true,
        body: "some body"
      }

      assert {:ok, %Comment{} = comment} = Comments.create_comment(valid_attrs)
      assert !comment.approved?
      assert comment.body == "some body"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comments.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      update_attrs = %{approved?: false, body: "some updated body"}

      assert {:ok, %Comment{} = comment} = Comments.update_comment(comment, update_attrs)
      assert comment.approved? == false
      assert comment.body == "some updated body"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Comments.update_comment(comment, @invalid_attrs)
      assert_near_eq(comment, Comments.get_comment!(comment.id))
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Comments.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Comments.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Comments.change_comment(comment)
    end
  end
end
