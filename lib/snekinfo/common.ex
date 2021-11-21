defmodule Snekinfo.Common do
  def try_get(%Ecto.Association.NotLoaded{}, []), do: "BUG: AssocNotLoaded"
  def try_get(obj, []), do: obj
  def try_get(obj, [k|ks]) do
    if obj do
      try_get(Map.get(obj, k), ks)
    else
      nil
    end
  end
  def try_get(obj, k) do
    try_get(obj, [k])
  end

  def try_get0(%Ecto.Association.NotLoaded{}, _), do: "BUG: AssocNotLoaded"
  def try_get0(xs, ys) do
    try_get(Enum.at(xs, 0), ys)
  end
end
