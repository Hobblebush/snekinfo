defmodule Snekinfo.WeightsTest do
  use Snekinfo.DataCase

  alias Snekinfo.Weights

  describe "weights" do
    alias Snekinfo.Weights.Weight

    import Snekinfo.WeightsFixtures

    @invalid_attrs %{timestamp: nil, weight: nil}

    test "list_weights/0 returns all weights" do
      weight = weight_fixture()
      assert Weights.list_weights() == [weight]
    end

    test "get_weight!/1 returns the weight with given id" do
      weight = weight_fixture()
      assert Weights.get_weight!(weight.id) == weight
    end

    test "create_weight/1 with valid data creates a weight" do
      valid_attrs = %{timestamp: ~U[2021-10-20 23:42:00Z], weight: 120.5}

      assert {:ok, %Weight{} = weight} = Weights.create_weight(valid_attrs)
      assert weight.timestamp == ~U[2021-10-20 23:42:00Z]
      assert weight.weight == 120.5
    end

    test "create_weight/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Weights.create_weight(@invalid_attrs)
    end

    test "update_weight/2 with valid data updates the weight" do
      weight = weight_fixture()
      update_attrs = %{timestamp: ~U[2021-10-21 23:42:00Z], weight: 456.7}

      assert {:ok, %Weight{} = weight} = Weights.update_weight(weight, update_attrs)
      assert weight.timestamp == ~U[2021-10-21 23:42:00Z]
      assert weight.weight == 456.7
    end

    test "update_weight/2 with invalid data returns error changeset" do
      weight = weight_fixture()
      assert {:error, %Ecto.Changeset{}} = Weights.update_weight(weight, @invalid_attrs)
      assert weight == Weights.get_weight!(weight.id)
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
