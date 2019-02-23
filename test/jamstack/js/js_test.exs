defmodule Jamstack.JSTest do
  use Jamstack.DataCase

  alias Jamstack.JS

  describe "parties" do
    alias Jamstack.JS.Party

    @valid_attrs %{active: true, auth_token: "some auth_token", join_code: "some join_code", refresh_token: "some refresh_token", title: "some title"}
    @update_attrs %{active: false, auth_token: "some updated auth_token", join_code: "some updated join_code", refresh_token: "some updated refresh_token", title: "some updated title"}
    @invalid_attrs %{active: nil, auth_token: nil, join_code: nil, refresh_token: nil, title: nil}

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
      assert party.auth_token == "some auth_token"
      assert party.join_code == "some join_code"
      assert party.refresh_token == "some refresh_token"
      assert party.title == "some title"
    end

    test "create_party/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = JS.create_party(@invalid_attrs)
    end

    test "update_party/2 with valid data updates the party" do
      party = party_fixture()
      assert {:ok, %Party{} = party} = JS.update_party(party, @update_attrs)
      assert party.active == false
      assert party.auth_token == "some updated auth_token"
      assert party.join_code == "some updated join_code"
      assert party.refresh_token == "some updated refresh_token"
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
