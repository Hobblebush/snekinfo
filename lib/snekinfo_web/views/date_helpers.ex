defmodule SnekinfoWeb.DateHelpers do
  use Phoenix.HTML

  def datetime_input(ff, name, rest \\ []) do
    datetime_local_input(ff, name, add_class(rest, "datetime-local-input"))
  end

  def add_class(props, name) do
    props = Enum.into(props, %{})

    class = props
    |> Map.get(:class, "")
    |> String.split()
    |> List.insert_at(0, name)
    |> Enum.join(" ")

    Map.put(props, :class, class)
    |> Enum.into([])
  end
end
