defmodule LilLinks.Repo do
  use Ecto.Repo,
    otp_app: :lil_links,
    adapter: Ecto.Adapters.Postgres
end
