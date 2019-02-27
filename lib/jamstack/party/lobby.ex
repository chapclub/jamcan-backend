defmodule Jamstack.Party.Lobby do
  use Agent

  def start_link(_opts) do
    Agent.start_link(
      fn ->
        %{ }
      end,
      name: __MODULE__
    )
  end

  def create_lobby(join_code) do
    Agent.update(
      __MODULE__,
      fn lobby ->
        Map.put(
          lobby,
          join_code,
          []
        )
      end
    )
  end

  def join_lobby(join_code, user_name) do
    Agent.update(
      __MODULE__,
      fn lobby ->
        Map.put(
          lobby,
          join_code,
          [ user_name | lobby[join_code]  ]
        )
      end
    )
  end

  def leave_lobby(join_code, user_name) do
    Agent.update(
      __MODULE__,
      fn lobby ->
        Map.put(
          lobby,
          join_code,
          Enum.filter(
            lobby[join_code],
            fn user -> user != user_name end
          )
        )
      end
    )
  end

  def get_lobby(join_code) do
    Agent.get(
      __MODULE__,
      fn lobby ->
        Map.get(
          lobby,
          join_code
        )
      end
    )
  end

  def remove_lobby(join_code) do
    Agent.update(
      __MODULE__,
      fn lobby ->
        Map.pop(
          lobby,
          join_code
        )
      end
    )
  end
end
