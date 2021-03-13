defmodule Hw07.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :prof_pic_hash, :string
    has_many :events, Hw07.Events.Event
    has_many :comments, Hw07.Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :prof_pic_hash])
    |> validate_required([:name, :email, :prof_pic_hash])
  end
end
