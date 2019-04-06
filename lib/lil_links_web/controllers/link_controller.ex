defmodule LilLinksWeb.LinkController do
  use LilLinksWeb, :controller

  alias LilLinks.Links
  alias LilLinks.Links.Link

  action_fallback LilLinksWeb.FallbackController

  def index(conn, _params) do
    link = Links.list_link()
    render(conn, "index.json", link: link)
  end

  def create(conn, %{"link" => link_params}) do
    IO.inspect(link_params)

    with {:ok, %Link{} = link} <- Links.create_link(link_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.link_path(conn, :show, link))
      |> render("show.json", link: link)
    end
  end

  def show(conn, %{"id" => id}) do
    link = Links.get_link!(id)
    render(conn, "show.json", link: link)
  end

  def update(conn, %{"id" => id, "link" => link_params}) do
    link = Links.get_link!(id)

    with {:ok, %Link{} = link} <- Links.update_link(link, link_params) do
      render(conn, "show.json", link: link)
    end
  end

  def delete(conn, %{"id" => id}) do
    link = Links.get_link!(id)

    with {:ok, %Link{}} <- Links.delete_link(link) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_and_redirect(conn, %{"hash" => hash}) do
    url =
      hash
      |> Links.get_original_link()

    # |> Links.get_link_from_url()
    # |> Links.increment_clicks()
    IO.inspect(url)
    redirect(conn, external: url)
  end
end
