defmodule Snekinfo.Common do
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
end
