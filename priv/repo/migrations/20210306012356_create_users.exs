defmodule Hw07.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :prof_pic_hash, :string, default: ""

      timestamps()
    end

  end
end
