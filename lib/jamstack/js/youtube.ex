defmodule Jamstack.JS.Youtube do
  use Agent

  alias Goth.Token
  alias GoogleApi.YouTube.V3.Connection
  alias GoogleApi.YouTube.V3.Api.Search

  def get_google_conn do
    {:ok, token} = Token.for_scope("https://www.googleapis.com/auth/youtube")
    Connection.new(token.token)
  end

  def start_link(_opts) do
    Agent.start_link(
      fn ->
        get_google_conn()
      end,
      name: __MODULE__
    )
  end

  def search(term) do
    Agent.get(__MODULE__, fn conn ->
      Search.youtube_search_list(
        conn,
        "snippet",
        q: term
      )
    end)
  end
end
