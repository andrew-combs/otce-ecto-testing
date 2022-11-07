defmodule Otce.Repo.Migrations.CreatePostsReactions do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :text, :string

      timestamps()
    end

    create table(:reactions) do
      add :post_id, references(:posts, on_delete: :delete_all)

      add :reaction, :integer

      timestamps()
    end

    create unique_index(:reactions, [:post_id, :reaction], name: :reaction_unique_in_post)
  end
end
