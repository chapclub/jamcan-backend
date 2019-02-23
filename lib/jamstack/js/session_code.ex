defmodule Jamstack.JS.SessionCode do
  @corpus File.read!("/usr/share/dict/words") |> String.split(~r/\n/) |> Enum.filter(fn word -> String.length(word) > 2 && String.length(word) < 5 end)

  def take_code do
    @corpus
    |> Enum.take_random(2)
    |> Enum.join("-")
    |> String.downcase()
  end
end
