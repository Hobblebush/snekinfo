defmodule Snekinfo.Repo do
  use Ecto.Repo,
    otp_app: :snekinfo,
    adapter: Ecto.Adapters.Postgres
end
