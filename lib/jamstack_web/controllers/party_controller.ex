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

  @doc """
  Handles the /aux form result to set the party id within the session. When
  working with the song request frontend, a song is inserted into the party id
  found within the session.
  """
  def join(conn, %{"join" => form_data}) do
    %{
      "join_code" => join_code,
      "name" => name,
    } = form_data

    case JS.get_party_by_join_code(join_code) do
      %Party{} = party ->
        fetch_session(conn)
        |> put_session(:party_id, party.id)
        |> put_session(:name, name)
        |> redirect(to: "/aux")
      nil ->
        conn
        |> redirect(to: Routes.page_path(conn, :join_party, not_found: true))
      _ ->
        conn
        |> redirect(to: Routes.page_path(conn, :join_party, wat: true))
    end

  end
end
