defmodule LilLinksWeb.LinkControllerTest do
  use LilLinksWeb.ConnCase

  alias LilLinks.Links
  alias LilLinks.Links.Link

  @create_attrs %{
    clicks: 42,
    expires: true,
    expiry: ~N[2010-04-17 14:00:00],
    hash: "some hash",
    site_title: "some site_title",
    url: "some url"
  }
  @update_attrs %{
    clicks: 43,
    expires: false,
    expiry: ~N[2011-05-18 15:01:01],
    hash: "some updated hash",
    site_title: "some updated site_title",
    url: "some updated url"
  }
  @invalid_attrs %{clicks: nil, expires: nil, expiry: nil, hash: nil, site_title: nil, url: nil}

  def fixture(:link) do
    {:ok, link} = Links.create_link(@create_attrs)
    link
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all link", %{conn: conn} do
      conn = get(conn, Routes.link_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create link" do
    test "renders link when data is valid", %{conn: conn} do
      conn = post(conn, Routes.link_path(conn, :create), link: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.link_path(conn, :show, id))

      assert %{
               "id" => id,
               "clicks" => 42,
               "expires" => true,
               "expiry" => "2010-04-17T14:00:00",
               "hash" => "some hash",
               "site_title" => "some site_title",
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.link_path(conn, :create), link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update link" do
    setup [:create_link]

    test "renders link when data is valid", %{conn: conn, link: %Link{id: id} = link} do
      conn = put(conn, Routes.link_path(conn, :update, link), link: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.link_path(conn, :show, id))

      assert %{
               "id" => id,
               "clicks" => 43,
               "expires" => false,
               "expiry" => "2011-05-18T15:01:01",
               "hash" => "some updated hash",
               "site_title" => "some updated site_title",
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, link: link} do
      conn = put(conn, Routes.link_path(conn, :update, link), link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete link" do
    setup [:create_link]

    test "deletes chosen link", %{conn: conn, link: link} do
      conn = delete(conn, Routes.link_path(conn, :delete, link))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.link_path(conn, :show, link))
      end
    end
  end

  defp create_link(_) do
    link = fixture(:link)
    {:ok, link: link}
  end
end
