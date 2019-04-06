defmodule LilLinksWeb.LinkView do
  use LilLinksWeb, :view
  alias LilLinksWeb.LinkView

  def render("index.json", %{link: link}) do
    %{data: render_many(link, LinkView, "link.json")}
  end

  def render("show.json", %{link: link}) do
    %{data: render_one(link, LinkView, "link.json")}
  end

  def render("link.json", %{link: link}) do
    %{id: link.id,
      url: link.url,
      hash: link.hash,
      clicks: link.clicks,
      site_title: link.site_title,
      expires: link.expires,
      expiry: link.expiry}
  end
end
