defmodule LilLinks.Links.Link do
  @moduledoc """
  The Link Model
  """
  use Ecto.Schema
  import Ecto.Changeset
  @hash_length 6

  schema "links" do
    field :url, :string
    field :hash, :string
    field :clicks, :integer, default: 0
    field :expires, :boolean, default: false
    field :expiry, :naive_datetime
    field :site_title, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :hash, :clicks, :site_title, :expires, :expiry])
    |> validate_required([:url])
    |> create_hash()
    |> unique_constraint(:hash)
  end

  ## Private ##
  defp create_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(changeset, :hash, generate_hash())

      _ ->
        changeset
    end
  end

  defp generate_hash() do
    @hash_length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    |> binary_part(0, @hash_length)
  end
end
