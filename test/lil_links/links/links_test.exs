defmodule LilLinks.LinksTest do
  use LilLinks.DataCase

  alias LilLinks.Links

  describe "link" do
    alias LilLinks.Links.Link

    @valid_attrs %{clicks: 42, expires: true, expiry: ~N[2010-04-17 14:00:00], hash: "some hash", site_title: "some site_title", url: "some url"}
    @update_attrs %{clicks: 43, expires: false, expiry: ~N[2011-05-18 15:01:01], hash: "some updated hash", site_title: "some updated site_title", url: "some updated url"}
    @invalid_attrs %{clicks: nil, expires: nil, expiry: nil, hash: nil, site_title: nil, url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Links.create_link()

      link
    end

    test "list_link/0 returns all link" do
      link = link_fixture()
      assert Links.list_link() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Links.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Links.create_link(@valid_attrs)
      assert link.clicks == 42
      assert link.expires == true
      assert link.expiry == ~N[2010-04-17 14:00:00]
      assert link.hash == "some hash"
      assert link.site_title == "some site_title"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      assert {:ok, %Link{} = link} = Links.update_link(link, @update_attrs)
      assert link.clicks == 43
      assert link.expires == false
      assert link.expiry == ~N[2011-05-18 15:01:01]
      assert link.hash == "some updated hash"
      assert link.site_title == "some updated site_title"
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Links.update_link(link, @invalid_attrs)
      assert link == Links.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Links.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Links.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Links.change_link(link)
    end
  end
end
