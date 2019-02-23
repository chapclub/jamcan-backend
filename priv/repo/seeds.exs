# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Jamstack.Repo.insert!(%Jamstack.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Jamstack.JS.Party

Jamstack.Repo.insert!(
  %Party{
      title: "Best Party",
      owner_id: "bobnisco",
      join_code: "meme-boys"
  }
)

Jamstack.Repo.insert!(
  %Party{
    title: "Cool Party 2",
    owner_id: "1212204105",
    join_code: "luck-meal"
  }
)

Jamstack.Repo.insert!(
  %Party{
    title: "meme land 7",
    owner_id: "12130660101",
    join_code: "doge-wine"
  }
)
