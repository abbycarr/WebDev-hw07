defmodule Hw07.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, null: false
      add :when, :date, null: false
      add :description, :text, null: false

      timestamps()
    end

  end
end
