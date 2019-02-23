defmodule Jamstack.SessionCodeTest do
  use ExUnit.Case
  alias Jamstack.JS.SessionCode

  describe "session codes" do
    test "generates a random 3 word code" do
      words = SessionCode.take_code()
      |> String.split("-")

      assert Enum.count(words) == 2

      Enum.each(words, fn word ->
        assert String.length(word) > 2
        assert String.length(word) < 5
      end)
    end
  end
end
