defmodule Snekinfo.ShedsTest do
  use Snekinfo.DataCase

  alias Snekinfo.Sheds

  describe "sheds" do
    alias Snekinfo.Sheds.Shed

    import Snekinfo.ShedsFixtures
    import Snekinfo.SnakesFixtures

    @invalid_attrs %{date: nil}

    test "list_sheds/0 returns all sheds" do
      shed = shed_fixture()
      assert_near_eq(Sheds.list_sheds(), [shed])
    end

    test "get_shed!/1 returns the shed with given id" do
      shed = shed_fixture()
      assert_near_eq(Sheds.get_shed!(shed.id), shed)
    end

    test "create_shed/1 with valid data creates a shed" do
      snake = snake_fixture()

      valid_attrs = %{snake_id: snake.id, date: ~D[2022-02-27]}

      assert {:ok, %Shed{} = shed} = Sheds.create_shed(valid_attrs)
      assert shed.date == ~D[2022-02-27]
    end

    test "create_shed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sheds.create_shed(@invalid_attrs)
    end

    test "update_shed/2 with valid data updates the shed" do
      shed = shed_fixture()
      update_attrs = %{date: ~D[2022-02-28]}

      assert {:ok, %Shed{} = shed} = Sheds.update_shed(shed, update_attrs)
      assert shed.date == ~D[2022-02-28]
    end

    test "update_shed/2 with invalid data returns error changeset" do
      shed = shed_fixture()
      assert {:error, %Ecto.Changeset{}} = Sheds.update_shed(shed, @invalid_attrs)
      assert_near_eq(shed, Sheds.get_shed!(shed.id))
    end

    test "delete_shed/1 deletes the shed" do
      shed = shed_fixture()
      assert {:ok, %Shed{}} = Sheds.delete_shed(shed)
      assert_raise Ecto.NoResultsError, fn -> Sheds.get_shed!(shed.id) end
    end

    test "change_shed/1 returns a shed changeset" do
      shed = shed_fixture()
      assert %Ecto.Changeset{} = Sheds.change_shed(shed)
    end
  end
end
