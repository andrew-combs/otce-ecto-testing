defmodule Otce.Posts.Post do
  use Ecto.Schema

  import Ecto.Changeset

  alias Otce.Posts.Reaction

  schema "posts" do
    field :text, :string

    has_many :reactions, Reaction, on_replace: :delete

    timestamps()
  end

  def changeset(%__MODULE__{} = post, attrs) do
    post
    |> cast(attrs, [:text])
    |> cast_assoc(:reactions, with: &Reaction.changeset/2)
  end
end
