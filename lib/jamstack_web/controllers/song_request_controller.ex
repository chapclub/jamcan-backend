defmodule JamstackWeb.SongRequestController do
  use JamstackWeb, :controller

  alias Jamstack.JS
  alias Jamstack.Party
  alias Jamstack.Party.SongRequest

  @doc """
  Given a connection, will look for the session party_id before rendering a
  page. If it is not found, it will put an error flash and redirect to the join
  party page. Otherwise, it'll return a tuple with the connection and party_id
  from the session.
  """
  defp protecc(conn) do
    party_id = fetch_session(conn)
    |> get_session(:party_id)

    name = fetch_session(conn)
    |> get_session(:name)

    case party_id do
      nil ->
        conn
        |> put_flash(:error, "Please join a party first!")
        |> redirect(to: Routes.page_path(conn, :join_party))
      _ -> { conn, { party_id, name } }
    end
  end

  def index(conn, _params) do
    { conn, { party_id, name } } = protecc(conn)

    song_requests = Party.list_song_requests()
    |> Enum.filter(fn req ->
      req.party_id == party_id
    end)

    party = JS.get_party!(party_id)

    render(conn, "index.html", song_requests: song_requests, party: party, name: name)
  end

  def new(conn, params) do
    { conn, { party_id, _ } } = protecc(conn)
    changeset = Party.change_song_request(%SongRequest{})

    query = params["query"]
    {status, results} = case query do
      nil -> {:ok, %{items: []}}
      _ -> Jamstack.JS.Youtube.search(query)
    end

    render(conn, "new.html", changeset: changeset, results: results.items, party_id: party_id)
  end

  def create(conn, %{"song_request" => song_request_params}) do
    { conn, _ } = protecc(conn)

    case Party.create_song_request(song_request_params) do
      {:ok, song_request} ->
        conn
        |> put_flash(:info, "Song request created successfully.")
        |> redirect(to: Routes.song_request_path(conn, :show, song_request))

      {:error, %Ecto.Changeset{} = changeset} ->
        throw changeset
        render(conn, "new.html", changeset: changeset, results: [], party_id: nil)
    end
  end

  def show(conn, %{"id" => id}) do
    { conn, _ } = protecc(conn)

    song_request = Party.get_song_request!(id)
    render(conn, "show.html", song_request: song_request)
  end

  def edit(conn, %{"id" => id}) do
    { conn, _ } = protecc(conn)

    song_request = Party.get_song_request!(id)
    changeset = Party.change_song_request(song_request)
    render(conn, "edit.html", song_request: song_request, changeset: changeset)
  end

  def update(conn, %{"id" => id, "song_request" => song_request_params}) do
    { conn, _ } = protecc(conn)

    song_request = Party.get_song_request!(id)

    case Party.update_song_request(song_request, song_request_params) do
      {:ok, song_request} ->
        conn
        |> put_flash(:info, "Song request updated successfully.")
        |> redirect(to: Routes.song_request_path(conn, :show, song_request))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", song_request: song_request, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    { conn, _ } = protecc(conn)

    song_request = Party.get_song_request!(id)
    {:ok, _song_request} = Party.delete_song_request(song_request)

    conn
    |> put_flash(:info, "Song request deleted successfully.")
    |> redirect(to: Routes.song_request_path(conn, :index))
  end
end
