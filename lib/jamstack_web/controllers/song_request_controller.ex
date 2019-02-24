defmodule JamstackWeb.SongRequestController do
  use JamstackWeb, :controller

  alias Jamstack.Party
  alias Jamstack.Party.SongRequest

  def index(conn, _params) do
    song_requests = Party.list_song_requests()

    party_id = fetch_session(conn)
    |> get_session(:party_id)

    render(conn, "index.html", song_requests: song_requests, party_id: party_id)
  end

  def new(conn, _params) do
    changeset = Party.change_song_request(%SongRequest{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"song_request" => song_request_params}) do
    case Party.create_song_request(song_request_params) do
      {:ok, song_request} ->
        conn
        |> put_flash(:info, "Song request created successfully.")
        |> redirect(to: Routes.song_request_path(conn, :show, song_request))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    song_request = Party.get_song_request!(id)
    render(conn, "show.html", song_request: song_request)
  end

  def edit(conn, %{"id" => id}) do
    song_request = Party.get_song_request!(id)
    changeset = Party.change_song_request(song_request)
    render(conn, "edit.html", song_request: song_request, changeset: changeset)
  end

  def update(conn, %{"id" => id, "song_request" => song_request_params}) do
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
    song_request = Party.get_song_request!(id)
    {:ok, _song_request} = Party.delete_song_request(song_request)

    conn
    |> put_flash(:info, "Song request deleted successfully.")
    |> redirect(to: Routes.song_request_path(conn, :index))
  end
end
