defmodule Otce.Posts.Reaction do
  use Ecto.Schema

  import Ecto.Changeset

  alias Otce.Posts.Post

  schema "reactions" do
    field :reaction, :integer

    belongs_to :post, Post

    timestamps()
  end

  def changeset(%__MODULE__{} = reaction, attrs) do
    reaction
    |> cast(attrs, [:reaction, :post_id])
    |> validate_required([:reaction])
    |> foreign_key_constraint(:post_id)
    |> unique_constraint([:post_id, :reaction], name: :reaction_unique_in_post)
  end
end
