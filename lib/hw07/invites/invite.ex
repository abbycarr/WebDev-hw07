defmodule Hw07.Invites.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invites" do
    field :response, :string
    field :email, :string
    belongs_to :event, Hw07.Events.Event

    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:response, :email, :event_id])
    |> validate_required([:response, :email, :event_id])
  end
end
