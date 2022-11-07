defmodule Otce.PostsTest do
  use Otce.DataCase
  alias Otce.Posts

  describe "create_post/1" do
    test "creates a post" do
      assert %{id: _some_id} =
               Posts.create_post(%{
                 reactions: [
                   %{
                     reaction: 1
                   },
                   %{
                     reaction: 2
                   }
                 ]
               })
    end
  end
end
