use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lil_links, LilLinksWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :lil_links, LilLinks.Repo,
  username: "postgres",
  password: "postgres",
  database: "lil_links_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure Argon2
config :argon2_elixir, t_cost: 1, m_cost: 8
