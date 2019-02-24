defmodule Jamstack.PartyTest do
  use Jamstack.DataCase

  alias Jamstack.Party

  describe "song_requests" do
    alias Jamstack.Party.SongRequest

    @valid_attrs %{boo_count: 42, spotify_uri: "some spotify_uri"}
    @update_attrs %{boo_count: 43, spotify_uri: "some updated spotify_uri"}
    @invalid_attrs %{boo_count: nil, spotify_uri: nil}

    def song_request_fixture(attrs \\ %{}) do
      {:ok, song_request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Party.create_song_request()

      song_request
    end

    test "list_song_requests/0 returns all song_requests" do
      song_request = song_request_fixture()
      assert Party.list_song_requests() == [song_request]
    end

    test "get_song_request!/1 returns the song_request with given id" do
      song_request = song_request_fixture()
      assert Party.get_song_request!(song_request.id) == song_request
    end

    test "create_song_request/1 with valid data creates a song_request" do
      assert {:ok, %SongRequest{} = song_request} = Party.create_song_request(@valid_attrs)
      assert song_request.boo_count == 42
      assert song_request.spotify_uri == "some spotify_uri"
    end

    test "create_song_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Party.create_song_request(@invalid_attrs)
    end

    test "update_song_request/2 with valid data updates the song_request" do
      song_request = song_request_fixture()
      assert {:ok, %SongRequest{} = song_request} = Party.update_song_request(song_request, @update_attrs)
      assert song_request.boo_count == 43
      assert song_request.spotify_uri == "some updated spotify_uri"
    end

    test "update_song_request/2 with invalid data returns error changeset" do
      song_request = song_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Party.update_song_request(song_request, @invalid_attrs)
      assert song_request == Party.get_song_request!(song_request.id)
    end

    test "delete_song_request/1 deletes the song_request" do
      song_request = song_request_fixture()
      assert {:ok, %SongRequest{}} = Party.delete_song_request(song_request)
      assert_raise Ecto.NoResultsError, fn -> Party.get_song_request!(song_request.id) end
    end

    test "change_song_request/1 returns a song_request changeset" do
      song_request = song_request_fixture()
      assert %Ecto.Changeset{} = Party.change_song_request(song_request)
    end
  end
end
