# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Hw07.Repo.insert!(%Hw07.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# alias Hw07.Repo
# alias Hw07.Users.User
# alias Hw07.Events.Event

# sam = Repo.insert!(%User{name: "Sam", email: "s@sol.com"})
# samantha = Repo.insert!(%User{name: "Samantha", email: "ss@soul.com"})

# Repo.insert!(%Event{user_id: sam.id, name: "Sam buys Pillows", when: ~D[2023-09-18], description: "Sam is lame and needs some cute throw pillows to be less lame" })
# Repo.insert!(%Event{user_id: samantha.id, name: "Walk Dogs", when: ~D[2023-02-03], description: "Everyone gathers as many dogs as possible and we walk ALL of them at once" })
