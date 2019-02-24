defmodule JamstackWeb.PageController do
  use JamstackWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def join_party(conn, params) do
    render(conn, "join_party.html")
  end
end
