defmodule Snekinfo.WeightsTest do
  use Snekinfo.DataCase

  alias Snekinfo.Weights
  alias Snekinfo.SnakesFixtures

  describe "weights" do
    alias Snekinfo.Weights.Weight

    import Snekinfo.WeightsFixtures

    @invalid_attrs %{date: "goat", weight: -99.3}

    test "list_weights/0 returns all weights" do
      weight = weight_fixture()
      assert_near_eq(Weights.list_weights(), [weight])
    end

    test "get_weight!/1 returns the weight with given id" do
      weight = weight_fixture()
      assert_near_eq(Weights.get_weight!(weight.id), weight)
    end

    test "create_weight/1 with valid data creates a weight" do
      snake = SnakesFixtures.snake_fixture()
      valid_attrs = %{snake_id: snake.id, date: ~D[2021-10-20], weight: 120.5}

      assert {:ok, %Weight{} = weight} = Weights.create_weight(valid_attrs)
      assert weight.date == ~D[2021-10-20]
      assert weight.weight == 120.5
    end

    test "create_weight/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Weights.create_weight(@invalid_attrs)
    end

    test "update_weight/2 with valid data updates the weight" do
      weight = weight_fixture()
      update_attrs = %{date: ~D[2021-10-21], weight: 456.7}

      assert {:ok, %Weight{} = weight} = Weights.update_weight(weight, update_attrs)
      assert weight.date == ~D[2021-10-21]
      assert weight.weight == 456.7
    end

    test "update_weight/2 with invalid data returns error changeset" do
      weight = weight_fixture()
      assert {:error, %Ecto.Changeset{}} = Weights.update_weight(weight, @invalid_attrs)
      assert_near_eq(weight, Weights.get_weight!(weight.id))
    end

    test "delete_weight/1 deletes the weight" do
      weight = weight_fixture()
      assert {:ok, %Weight{}} = Weights.delete_weight(weight)
      assert_raise Ecto.NoResultsError, fn -> Weights.get_weight!(weight.id) end
    end

    test "change_weight/1 returns a weight changeset" do
      weight = weight_fixture()
      assert %Ecto.Changeset{} = Weights.change_weight(weight)
    end
  end
end
