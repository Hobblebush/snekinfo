defmodule Snekinfo.TraitsTest do
  use Snekinfo.DataCase

  alias Snekinfo.Traits

  describe "traits" do
    alias Snekinfo.Traits.Trait

    import Snekinfo.TraitsFixtures

    @invalid_attrs %{inheritance: nil, name: nil}

    test "list_traits/0 returns all traits" do
      trait = trait_fixture()
      assert Traits.list_traits() == [trait]
    end

    test "get_trait!/1 returns the trait with given id" do
      trait = trait_fixture()
      assert Traits.get_trait!(trait.id) == trait
    end

    test "create_trait/1 with valid data creates a trait" do
      valid_attrs = %{inheritance: "dominant", name: "flippers"}

      assert {:ok, %Trait{} = trait} = Traits.create_trait(valid_attrs)
      assert trait.inheritance == "dominant"
      assert trait.name == "flippers"
    end

    test "create_trait/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Traits.create_trait(@invalid_attrs)
    end

    test "update_trait/2 with valid data updates the trait" do
      trait = trait_fixture()
      update_attrs = %{inheritance: "recessive", name: "toothless"}

      assert {:ok, %Trait{} = trait} = Traits.update_trait(trait, update_attrs)
      assert trait.inheritance == "recessive"
      assert trait.name == "toothless"
    end

    test "update_trait/2 with invalid data returns error changeset" do
      trait = trait_fixture()
      assert {:error, %Ecto.Changeset{}} = Traits.update_trait(trait, @invalid_attrs)
      assert trait == Traits.get_trait!(trait.id)
    end

    test "delete_trait/1 deletes the trait" do
      trait = trait_fixture()
      assert {:ok, %Trait{}} = Traits.delete_trait(trait)
      assert_raise Ecto.NoResultsError, fn -> Traits.get_trait!(trait.id) end
    end

    test "change_trait/1 returns a trait changeset" do
      trait = trait_fixture()
      assert %Ecto.Changeset{} = Traits.change_trait(trait)
    end
  end
end
