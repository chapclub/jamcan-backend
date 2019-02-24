defmodule JamstackWeb.Router do
  use JamstackWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JamstackWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/party", PageController, :join_party
    resources "/aux", SongRequestController
  end

  # Other scopes may use custom stacks.
  scope "/api", JamstackWeb do
    pipe_through :api

    post "/join", PartyController, :join
    resources "/parties", PartyController, except: [:new, :edit]
  end
end
