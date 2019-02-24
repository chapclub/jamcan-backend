defmodule JamstackWeb.PageController do
  use JamstackWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def join_party(conn, params) do
    conn = case params do
      %{"not_found" => "true"} ->
        conn
        |> put_flash(:error, "That join code is fake! Use a real one!")

      %{"wat" => "true"} ->
        conn
        |> put_flash(:error, "wat!")

      _ -> conn
    end

    render(conn, "join_party.html")
  end
end
