defmodule LilLinksWeb.Router do
  use LilLinksWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LilLinksWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    resources "/links", LinkController, except: [:new, :edit]
    get "/:hash", LinkController, :get_and_redirect
  end
end
