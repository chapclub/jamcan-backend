defmodule Jamstack.JSTest do
  use Jamstack.DataCase

  alias Jamstack.JS

  describe "parties" do
    alias Jamstack.JS.Party

    @valid_attrs %{active: true, join_code: "some join_code", owner_id: "some owner_id", title: "some title"}
    @update_attrs %{active: false, join_code: "some updated join_code", owner_id: "some updated owner_id", title: "some updated title"}
    @invalid_attrs %{active: nil, join_code: nil, owner_id: nil, title: nil}

    def party_fixture(attrs \\ %{}) do
      {:ok, party} =
        attrs
        |> Enum.into(@valid_attrs)
        |> JS.create_party()

      party
    end

    test "list_parties/0 returns all parties" do
      party = party_fixture()
      assert JS.list_parties() == [party]
    end

    test "get_party!/1 returns the party with given id" do
      party = party_fixture()
      assert JS.get_party!(party.id) == party
    end

    test "create_party/1 with valid data creates a party" do
      assert {:ok, %Party{} = party} = JS.create_party(@valid_attrs)
      assert party.active == true
      assert party.join_code == "some join_code"
      assert party.owner_id == "some owner_id"
      assert party.title == "some title"
    end

    test "create_party/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = JS.create_party(@invalid_attrs)
    end

    test "create_party/1 without a join_code will set a random code" do
      attrs = %{active: true, owner_id: "some owner_id", title: "some title"}

      assert {:ok, %Party{} = party} = JS.create_party(attrs)
      assert party.active == true
      assert party.owner_id == "some owner_id"
      assert party.title == "some title"

      assert party.join_code

      words = party.join_code
      |> String.split("-")

      assert Enum.count(words) == 2

      Enum.each(words, fn word ->
        assert String.length(word) > 2
        assert String.length(word) < 5
      end)

    end

    test "update_party/2 with valid data updates the party" do
      party = party_fixture()
      assert {:ok, %Party{} = party} = JS.update_party(party, @update_attrs)
      assert party.active == false
      assert party.join_code == "some updated join_code"
      assert party.owner_id == "some updated owner_id"
      assert party.title == "some updated title"
    end

    test "update_party/2 with invalid data returns error changeset" do
      party = party_fixture()
      assert {:error, %Ecto.Changeset{}} = JS.update_party(party, @invalid_attrs)
      assert party == JS.get_party!(party.id)
    end

    test "delete_party/1 deletes the party" do
      party = party_fixture()
      assert {:ok, %Party{}} = JS.delete_party(party)
      assert_raise Ecto.NoResultsError, fn -> JS.get_party!(party.id) end
    end

    test "change_party/1 returns a party changeset" do
      party = party_fixture()
      assert %Ecto.Changeset{} = JS.change_party(party)
    end
  end
end
