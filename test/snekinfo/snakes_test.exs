defmodule Snekinfo.SnakesTest do
  use Snekinfo.DataCase

  alias Snekinfo.Snakes

  describe "snakes" do
    alias Snekinfo.Snakes.Snake

    import Snekinfo.SnakesFixtures

    @invalid_attrs %{born: "goat", name: "", sex: "yes"}

    test "list_snakes/0 returns all snakes" do
      snake = snake_fixture()
      assert_near_eq(Snakes.list_snakes(), [snake])
    end

    test "get_snake!/1 returns the snake with given id" do
      snake = snake_fixture()
      assert_near_eq(Snakes.get_snake!(snake.id), snake)
    end

    test "create_snake/1 with valid data creates a snake" do
      valid_attrs = %{born: ~D[2021-10-20], name: "Sneko", sex: "F", traits: []}

      assert {:ok, %Snake{} = snake} = Snakes.create_snake(valid_attrs)
      assert snake.born == ~D[2021-10-20]
      assert snake.name == "Sneko"
      assert snake.sex == "F"
    end

    test "create_snake/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Snakes.create_snake(@invalid_attrs)
    end

    test "update_snake/2 with valid data updates the snake" do
      snake = snake_fixture()
      update_attrs = %{born: ~D[2021-10-21], name: "Steve", sex: "M"}

      assert {:ok, %Snake{} = snake} = Snakes.update_snake(snake, update_attrs)
      assert snake.born == ~D[2021-10-21]
      assert snake.name == "Steve"
      assert snake.sex == "M"
    end

    test "update_snake/2 with invalid data returns error changeset" do
      snake = snake_fixture()
      assert {:error, %Ecto.Changeset{}} = Snakes.update_snake(snake, @invalid_attrs)
      assert_near_eq(snake, Snakes.get_snake!(snake.id))
    end

    test "delete_snake/1 deletes the snake" do
      snake = snake_fixture()
      assert {:ok, %Snake{}} = Snakes.delete_snake(snake)
      assert_raise Ecto.NoResultsError, fn -> Snakes.get_snake!(snake.id) end
    end

    test "change_snake/1 returns a snake changeset" do
      snake = snake_fixture()
      assert %Ecto.Changeset{} = Snakes.change_snake(snake)
    end
  end
end
