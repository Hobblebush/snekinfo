defmodule Snekinfo.TaxaTest do
  use Snekinfo.DataCase

  alias Snekinfo.Taxa

  describe "species" do
    alias Snekinfo.Taxa.Species

    import Snekinfo.TaxaFixtures

    @invalid_attrs %{name: nil}

    test "list_species/0 includes one new species" do
      sp1 = species_fixture()
      xs = Taxa.list_species()
      xx = Enum.find(xs, &(&1.name == sp1.name))
      assert_near_eq(sp1, xx)
    end

    test "get_species!/1 returns the species with given id" do
      species = species_fixture()
      assert_near_eq(Taxa.get_species!(species.id), species)
    end

    test "create_species/1 with valid data creates a species" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Species{} = species} = Taxa.create_species(valid_attrs)
      assert species.name == "some name"
    end

    test "create_species/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taxa.create_species(@invalid_attrs)
    end

    test "update_species/2 with valid data updates the species" do
      species = species_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Species{} = species} = Taxa.update_species(species, update_attrs)
      assert species.name == "some updated name"
    end

    test "update_species/2 with invalid data returns error changeset" do
      species = species_fixture()
      assert {:error, %Ecto.Changeset{}} = Taxa.update_species(species, @invalid_attrs)
      assert species == Taxa.get_species!(species.id)
    end

    test "delete_species/1 deletes the species" do
      species = species_fixture()
      assert {:ok, %Species{}} = Taxa.delete_species(species)
      assert_raise Ecto.NoResultsError, fn -> Taxa.get_species!(species.id) end
    end

    test "change_species/1 returns a species changeset" do
      species = species_fixture()
      assert %Ecto.Changeset{} = Taxa.change_species(species)
    end
  end
end
