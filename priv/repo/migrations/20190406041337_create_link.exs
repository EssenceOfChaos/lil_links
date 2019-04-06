defmodule LilLinks.Repo.Migrations.CreateLink do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :string, null: false, unique: true
      add :hash, :string
      add :clicks, :integer, default: 0
      add :site_title, :string
      add :expires, :boolean, default: false, null: false
      add :expiry, :naive_datetime

      timestamps()
    end

    create unique_index(:links, [:hash])
  end
end
