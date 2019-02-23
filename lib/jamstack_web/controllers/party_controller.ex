defmodule JamstackWeb.PartyController do
  use JamstackWeb, :controller

  alias Jamstack.JS
  alias Jamstack.JS.Party

  action_fallback JamstackWeb.FallbackController

  def index(conn, _params) do
    parties = JS.list_parties()
    render(conn, "index.json", parties: parties)
  end

  def create(conn, %{"party" => party_params}) do
    with {:ok, %Party{} = party} <- JS.create_party(party_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.party_path(conn, :show, party))
      |> render("show.json", party: party)
    end
  end

  def show(conn, %{"id" => id}) do
    party = JS.get_party!(id)
    render(conn, "show.json", party: party)
  end

  def update(conn, %{"id" => id, "party" => party_params}) do
    party = JS.get_party!(id)

    with {:ok, %Party{} = party} <- JS.update_party(party, party_params) do
      render(conn, "show.json", party: party)
    end
  end

  def delete(conn, %{"id" => id}) do
    party = JS.get_party!(id)

    with {:ok, %Party{}} <- JS.delete_party(party) do
      send_resp(conn, :no_content, "")
    end
  end
end
