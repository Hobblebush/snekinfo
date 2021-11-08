defmodule Snekinfo.LittersTest do
  use Snekinfo.DataCase

  alias Snekinfo.Litters
  alias Snekinfo.SnakesFixtures

  describe "litters" do
    alias Snekinfo.Litters.Litter

    import Snekinfo.LittersFixtures

    @invalid_attrs %{born: nil}

    test "list_litters/0 returns all litters" do
      litter = litter_fixture()
      assert_near_eq(Litters.list_litters(), [litter])
    end

    test "get_litter!/1 returns the litter with given id" do
      litter = litter_fixture()
      assert_near_eq(Litters.get_litter!(litter.id), litter)
    end

    test "create_litter/1 with valid data creates a litter" do
      mother = SnakesFixtures.snake_fixture()

      valid_attrs = %{mother_id: mother.id, born: ~D[2021-10-20], stills: 0, slugs: 1}

      assert {:ok, %Litter{} = litter} = Litters.create_litter(valid_attrs)
      assert litter.born == ~D[2021-10-20]
    end

    test "create_litter/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Litters.create_litter(@invalid_attrs)
    end

    test "update_litter/2 with valid data updates the litter" do
      litter = litter_fixture()
      update_attrs = %{born: ~D[2021-10-21]}

      assert {:ok, %Litter{} = litter} = Litters.update_litter(litter, update_attrs)
      assert litter.born == ~D[2021-10-21]
    end

    test "update_litter/2 with invalid data returns error changeset" do
      litter = litter_fixture()
      assert {:error, %Ecto.Changeset{}} = Litters.update_litter(litter, @invalid_attrs)
      assert_near_eq(litter, Litters.get_litter!(litter.id))
    end

    test "delete_litter/1 deletes the litter" do
      litter = litter_fixture()
      assert {:ok, %Litter{}} = Litters.delete_litter(litter)
      assert_raise Ecto.NoResultsError, fn -> Litters.get_litter!(litter.id) end
    end

    test "change_litter/1 returns a litter changeset" do
      litter = litter_fixture()
      assert %Ecto.Changeset{} = Litters.change_litter(litter)
    end
  end
end
