defmodule JamstackWeb.PartyView do
  use JamstackWeb, :view
  alias JamstackWeb.PartyView

  def render("index.json", %{parties: parties}) do
    %{data: render_many(parties, PartyView, "party.json")}
  end

  def render("show.json", %{party: party, queue: queue}) do
    %{
      data: render_one(party, PartyView, "party.json"),
      queue: Enum.map(queue, fn req ->
        %{
          boo_count: req.boo_count,
          uri: req.spotify_uri,
          title: req.title,
        }
      end)
    }
  end

  def render("show.json", %{party: party}) do
    %{data: render_one(party, PartyView, "party.json")}
  end

  def render("party.json", %{party: party}) do
    %{id: party.id,
      title: party.title,
      join_code: party.join_code,
      active: party.active,
      owner_id: party.owner_id}
  end
end
