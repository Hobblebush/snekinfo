defmodule Snekinfo.Snake_traitsTest do
  use Snekinfo.DataCase

  alias Snekinfo.Snake_traits

  describe "snake_traits" do
    alias Snekinfo.Snake_traits.Snake_trait

    import Snekinfo.Snake_traitsFixtures

    @invalid_attrs %{}

    test "list_snake_traits/0 returns all snake_traits" do
      snake_trait = snake_trait_fixture()
      assert Snake_traits.list_snake_traits() == [snake_trait]
    end

    test "get_snake_trait!/1 returns the snake_trait with given id" do
      snake_trait = snake_trait_fixture()
      assert Snake_traits.get_snake_trait!(snake_trait.id) == snake_trait
    end

    test "create_snake_trait/1 with valid data creates a snake_trait" do
      valid_attrs = %{}

      assert {:ok, %Snake_trait{} = snake_trait} = Snake_traits.create_snake_trait(valid_attrs)
    end

    test "create_snake_trait/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Snake_traits.create_snake_trait(@invalid_attrs)
    end

    test "update_snake_trait/2 with valid data updates the snake_trait" do
      snake_trait = snake_trait_fixture()
      update_attrs = %{}

      assert {:ok, %Snake_trait{} = snake_trait} = Snake_traits.update_snake_trait(snake_trait, update_attrs)
    end

    test "update_snake_trait/2 with invalid data returns error changeset" do
      snake_trait = snake_trait_fixture()
      assert {:error, %Ecto.Changeset{}} = Snake_traits.update_snake_trait(snake_trait, @invalid_attrs)
      assert snake_trait == Snake_traits.get_snake_trait!(snake_trait.id)
    end

    test "delete_snake_trait/1 deletes the snake_trait" do
      snake_trait = snake_trait_fixture()
      assert {:ok, %Snake_trait{}} = Snake_traits.delete_snake_trait(snake_trait)
      assert_raise Ecto.NoResultsError, fn -> Snake_traits.get_snake_trait!(snake_trait.id) end
    end

    test "change_snake_trait/1 returns a snake_trait changeset" do
      snake_trait = snake_trait_fixture()
      assert %Ecto.Changeset{} = Snake_traits.change_snake_trait(snake_trait)
    end
  end
end
