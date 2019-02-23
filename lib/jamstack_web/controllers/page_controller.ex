defmodule JamstackWeb.PageController do
  use JamstackWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
