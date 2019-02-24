defmodule Jamstack.Party do
  @moduledoc """
  The Party context.
  """

  import Ecto.Query, warn: false
  alias Jamstack.Repo

  alias Jamstack.Party.SongRequest

  @doc """
  Returns the list of song_requests.

  ## Examples

      iex> list_song_requests()
      [%SongRequest{}, ...]

  """
  def list_song_requests do
    Repo.all(SongRequest)
  end

  @doc """
  Gets a single song_request.

  Raises `Ecto.NoResultsError` if the Song request does not exist.

  ## Examples

      iex> get_song_request!(123)
      %SongRequest{}

      iex> get_song_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_song_request!(id), do: Repo.get!(SongRequest, id)

  @doc """
  Creates a song_request.

  ## Examples

      iex> create_song_request(%{field: value})
      {:ok, %SongRequest{}}

      iex> create_song_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_song_request(attrs \\ %{}) do
    %SongRequest{}
    |> SongRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a song_request.

  ## Examples

      iex> update_song_request(song_request, %{field: new_value})
      {:ok, %SongRequest{}}

      iex> update_song_request(song_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_song_request(%SongRequest{} = song_request, attrs) do
    song_request
    |> SongRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SongRequest.

  ## Examples

      iex> delete_song_request(song_request)
      {:ok, %SongRequest{}}

      iex> delete_song_request(song_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_song_request(%SongRequest{} = song_request) do
    Repo.delete(song_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking song_request changes.

  ## Examples

      iex> change_song_request(song_request)
      %Ecto.Changeset{source: %SongRequest{}}

  """
  def change_song_request(%SongRequest{} = song_request) do
    SongRequest.changeset(song_request, %{})
  end
end
