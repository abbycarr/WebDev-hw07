defmodule Hw07.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :description, :string
    field :name, :string
    field :when, :date
    belongs_to :user, Hw07.Users.User

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :when, :description, :user_id])
    |> validate_required([:name, :when, :description, :user_id])
  end
end
