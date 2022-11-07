defmodule Otce.Repo do
  use Ecto.Repo,
    otp_app: :otce,
    adapter: Ecto.Adapters.Postgres
end
