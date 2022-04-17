defmodule SnekinfoWeb.SpeciesControllerTest do
  use SnekinfoWeb.ConnCase

  import Snekinfo.TaxaFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    setup [:log_as_staff]

    test "lists all species", %{conn: conn} do
      conn = get(conn, Routes.species_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Species"
    end
  end

  describe "new species" do
    setup [:log_as_staff]

    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.species_path(conn, :new))
      assert html_response(conn, 200) =~ "New Species"
    end
  end

  describe "create species" do
    setup [:log_as_staff]

    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.species_path(conn, :create), species: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.species_path(conn, :show, id)

      conn = get(conn, Routes.species_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Species"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.species_path(conn, :create), species: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Species"
    end
  end

  describe "edit species" do
    setup [:create_species, :log_as_staff]

    test "renders form for editing chosen species", %{conn: conn, species: species} do
      conn = get(conn, Routes.species_path(conn, :edit, species))
      assert html_response(conn, 200) =~ "Edit Species"
    end
  end

  describe "update species" do
    setup [:create_species, :log_as_staff]

    test "redirects when data is valid", %{conn: conn, species: species} do
      conn = put(conn, Routes.species_path(conn, :update, species), species: @update_attrs)
      assert redirected_to(conn) == Routes.species_path(conn, :show, species)

      conn = get(conn, Routes.species_path(conn, :show, species))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, species: species} do
      conn = put(conn, Routes.species_path(conn, :update, species), species: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Species"
    end
  end

  describe "delete species" do
    setup [:create_species, :log_as_staff]

    test "deletes chosen species", %{conn: conn, species: species} do
      conn = delete(conn, Routes.species_path(conn, :delete, species))
      assert redirected_to(conn) == Routes.species_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.species_path(conn, :show, species))
      end
    end
  end

  defp create_species(_) do
    species = species_fixture()
    %{species: species}
  end
end
