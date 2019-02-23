defmodule Jamstack.JS.SessionCode do
  use Agent

  @corpus File.read!("/usr/share/dict/words") |> String.split(~r/\n/) |> Enum.filter(fn word -> String.length(word) > 2 && String.length(word) < 5 end)

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @doc """
  Check the session code cache to determine if the given code has been used.
  """
  def code_exists?(code) do
    Agent.get(__MODULE__, fn cache ->
      Map.get(cache, code) == :used
    end)
  end

  @doc """
  Given a code and a flag indicating existence within the cache, generate a new
  code recursively until existence is false and update the cache with the given
  code. Returns the ultimately inserted code.
  """
  def put_code(_, true), do: take_code()
  def put_code(code, false) do
    Agent.update(__MODULE__, &Map.put(&1, code, :used))
    code
  end

  @doc """
  Returns a unique two-word session join code.
  """
  def take_code do
    code = @corpus
    |> Enum.take_random(2)
    |> Enum.join("-")
    |> String.downcase()

    put_code(code, code_exists?(code))
  end
end
