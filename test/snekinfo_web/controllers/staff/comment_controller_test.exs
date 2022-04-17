defmodule SnekinfoWeb.Staff.CommentControllerTest do
  use SnekinfoWeb.ConnCase

  import Snekinfo.CommentsFixtures

  @update_attrs %{ approved?: true }
  @invalid_attrs %{}

  describe "index" do
    setup [:log_as_staff]

    test "lists all comments", %{conn: conn} do
      conn = get(conn, Routes.staff_comment_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Comments"
    end
  end

  describe "edit comment" do
    setup [:create_comment, :log_as_staff]

    test "renders form for editing chosen comment", %{conn: conn, comment: comment} do
      conn = get(conn, Routes.staff_comment_path(conn, :edit, comment))
      assert html_response(conn, 200) =~ "Edit Comment"
    end
  end

  describe "update comment" do
    setup [:create_comment, :log_as_staff]

    test "redirects when data is valid", %{conn: conn, comment: comment} do
      conn = put(conn, Routes.staff_comment_path(conn, :update, comment),
        comment: @update_attrs)
      assert redirected_to(conn) == Routes.staff_comment_path(conn, :show, comment)

      conn = get(conn, Routes.staff_comment_path(conn, :show, comment))
      assert html_response(conn, 200) =~ ~r/Approved\?:[^p]+true/
    end

    test "renders errors when data is invalid", %{conn: conn, comment: comment} do
      conn = put(conn, Routes.staff_comment_path(conn, :update, comment),
        comment: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Comment"
    end
  end

  describe "delete comment" do
    setup [:create_comment, :log_as_staff]

    test "deletes chosen comment", %{conn: conn, comment: comment} do
      conn = delete(conn, Routes.staff_comment_path(conn, :delete, comment))
      assert redirected_to(conn) == Routes.staff_comment_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.staff_comment_path(conn, :show, comment))
      end
    end
  end

  defp create_comment(_) do
    comment = comment_fixture()
    %{comment: comment}
  end
end
