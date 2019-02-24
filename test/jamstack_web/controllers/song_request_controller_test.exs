defmodule JamstackWeb.SongRequestControllerTest do
  use JamstackWeb.ConnCase

  alias Jamstack.Party

  @create_attrs %{boo_count: 42, spotify_uri: "some spotify_uri"}
  @update_attrs %{boo_count: 43, spotify_uri: "some updated spotify_uri"}
  @invalid_attrs %{boo_count: nil, spotify_uri: nil}

  def fixture(:song_request) do
    {:ok, song_request} = Party.create_song_request(@create_attrs)
    song_request
  end

  describe "index" do
    test "lists all song_requests", %{conn: conn} do
      conn = get(conn, Routes.song_request_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Song requests"
    end
  end

  describe "new song_request" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.song_request_path(conn, :new))
      assert html_response(conn, 200) =~ "New Song request"
    end
  end

  describe "create song_request" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.song_request_path(conn, :create), song_request: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.song_request_path(conn, :show, id)

      conn = get(conn, Routes.song_request_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Song request"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.song_request_path(conn, :create), song_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Song request"
    end
  end

  describe "edit song_request" do
    setup [:create_song_request]

    test "renders form for editing chosen song_request", %{conn: conn, song_request: song_request} do
      conn = get(conn, Routes.song_request_path(conn, :edit, song_request))
      assert html_response(conn, 200) =~ "Edit Song request"
    end
  end

  describe "update song_request" do
    setup [:create_song_request]

    test "redirects when data is valid", %{conn: conn, song_request: song_request} do
      conn = put(conn, Routes.song_request_path(conn, :update, song_request), song_request: @update_attrs)
      assert redirected_to(conn) == Routes.song_request_path(conn, :show, song_request)

      conn = get(conn, Routes.song_request_path(conn, :show, song_request))
      assert html_response(conn, 200) =~ "some updated spotify_uri"
    end

    test "renders errors when data is invalid", %{conn: conn, song_request: song_request} do
      conn = put(conn, Routes.song_request_path(conn, :update, song_request), song_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Song request"
    end
  end

  describe "delete song_request" do
    setup [:create_song_request]

    test "deletes chosen song_request", %{conn: conn, song_request: song_request} do
      conn = delete(conn, Routes.song_request_path(conn, :delete, song_request))
      assert redirected_to(conn) == Routes.song_request_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.song_request_path(conn, :show, song_request))
      end
    end
  end

  defp create_song_request(_) do
    song_request = fixture(:song_request)
    {:ok, song_request: song_request}
  end
end
