defmodule Snekinfo.DataCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's data layer.

  You may define functions here to be used as helpers in
  your tests.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use Snekinfo.DataCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias Snekinfo.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Snekinfo.DataCase
    end
  end

  setup tags do
    pid = Ecto.Adapters.SQL.Sandbox.start_owner!(Snekinfo.Repo, shared: not tags[:async])
    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
    :ok
  end

  @doc """
  A helper that transforms changeset errors into a map of messages.

      assert {:error, changeset} = Accounts.create_user(%{password: "short"})
      assert "password is too short" in errors_on(changeset).password
      assert %{password: ["password is too short"]} = errors_on(changeset)

  """
  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end

  def assert_near_eq(xs, ys) when is_list(xs) do
    assert is_list(ys)

    Enum.each Enum.zip(xs, ys), fn {aa, bb} ->
      assert_near_eq(aa, bb)
    end
  end
  def assert_near_eq(aa, bb) do
    assert is_map(aa) && is_map(bb)

    aa1 = Map.from_struct(aa)
    bb1 = Map.from_struct(bb)

    assert Map.keys(aa1) == Map.keys(bb1)

    Enum.each Map.keys(aa1), fn kk ->
      if !eanl?(aa1[kk]) && !eanl?(bb1[kk]) do
        assert {kk, aa1[kk]} == {kk, bb1[kk]}
      end
    end
  end

  defp eanl?(%Ecto.Association.NotLoaded{}), do: true
  defp eanl?(_any), do: false
end
