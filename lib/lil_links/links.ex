defmodule LilLinks.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias LilLinks.Repo
  alias __MODULE__
  alias LilLinks.Links.Link

  @doc """
  Returns the list of links.
  """
  def list_links do
    Repo.all(Link)
  end

  @doc """
  Gets a single link.
  Raises `Ecto.NoResultsError` if the Link does not exist.
  """
  def get_link!(id), do: Repo.get!(Link, id)

  @doc """
  Given a hash, return the original url
  """
  def get_original_link(hash) do
    query =
      from l in "links",
        where: l.hash == ^hash,
        select: l.url

    Repo.one(query)
  end

  def get_link_from_url(original_url) do
    query =
      from l in "links",
        where: l.url == ^original_url,
        select: l.id

    Repo.one(query)
    |> Links.get_link!()
  end

  def increment_clicks(%Link{} = link) do
    clicks = link.clicks || 0

    link
    |> Link.changeset(%{clicks: clicks + 1})
    |> Repo.update()
  end

  @doc """
  Create a new link in the db
  """
  def create_link(attrs \\ %{}) do
    # Get the title of the site to save with the link
    title = fetch_title(attrs["url"])

    %Link{site_title: title}
    |> Link.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a link
  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Link.
  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{source: %Link{}}

  """
  def change_link(%Link{} = link) do
    Link.changeset(link, %{})
  end

  ## Private ##
  defp fetch_title(site) do
    case HTTPoison.get(site) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Floki.find("title")
        |> Floki.text()

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
