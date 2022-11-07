# Otce

Repository to recreate the issue described in the Elixir slack org (message recreated below)

---

I'm seeing an interesting behavior in testing unique_constraints:

Suppose I have the following schemas:

```elixir
schema "posts" do
   has_many :reactions, Reaction
end


schema "reactions" do
   belongs_to :post, Posts
   field :email, :string
   field :reaction, :integer
end
```

And I want to implement a unique_constraint on Reaction, such that a given post can't have the same reaction more than once. I'd implement it something like this (which works, just testing in iex):

# in migration
```elixir
create unique_index(:reaction, [:post_id, :reaction], name: :reaction_unique_in_post)
```

# In reactions.ex
```elixir
defmodule MyApp.Reactions do

# schema definition
# ...

def changeset(%__MODULE__{} = reaction, attrs) do
   reaction
   |> cast(attrs, @all_attrs)
   |> ...other validations
   |> unique_constraint(:post_id, name: :reaction_unique_in_post)
end
```

However, when I try to write a test that relies on this unique validation (by calling the Reactions.changeset/2 function and then piping it into Repo.insert/1) the write succeeds: I'm able to write two separate Reaction records with the same email/reaction combination associated with the same Post.

Anyone have an idea as to why this works in iex and not in a test suite? 

## To run

Start up an `iex` session in the desired `MIX_ENV` and run the driving posts function:

```
$ iex -S mix

iex(1)> Otce.Posts.create_a_bad_post()
...
```

The unique constraint should cause the function to fail