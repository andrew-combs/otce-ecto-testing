defmodule Otce.Posts do
  alias Otce.Posts.{Post, Reaction}
  alias Otce.Repo

  def create_post(attrs) do
    %{
      text: generate_random_text(),
      reactions: []
    }
    |> Map.merge(attrs)
    |> then(&Post.changeset(%Post{}, &1))
    |> Repo.insert!()
  end

  def create_reaction(attrs) do
    %Reaction{}
    |> Reaction.changeset(attrs)
    |> Repo.insert!()
  end

  def create_a_bad_post() do
    %{
      text: generate_random_text(),
      reactions: [
        %{
          reaction: 1
        },
        %{
          reaction: 1
        }
      ]
    }
    |> create_post()
  end

  @lorem_ipsum """
  Lorem ipsum dolor sit amet, consectetur adipiscing elit,
  sed do eiusmod tempor incididunt ut labore et dolore magna
  aliqua. Tellus cras adipiscing enim eu turpis egestas pretium.
  Duis at consectetur lorem donec. Id aliquet lectus proin nibh
  nisl. Sed augue lacus viverra vitae congue eu consequat ac.
  Platea dictumst quisque sagittis purus sit amet. Neque vitae
  tempus quam pellentesque. Mauris vitae ultricies leo integer
  malesuada nunc vel risus. Elit ut aliquam purus sit amet
  luctus venenatis lectus magna. Eu sem integer vitae justo eget
  magna fermentum iaculis. Et molestie ac feugiat sed. Vulputate
  mi sit amet mauris. Sit amet massa vitae tortor condimentum
  lacinia quis vel. Dui accumsan sit amet nulla facilisi morbi
  tempus iaculis urna. Gravida rutrum quisque non tellus orci ac
  auctor. Massa vitae tortor condimentum lacinia quis vel eros
  donec. Justo laoreet sit amet cursus sit. Congue nisi vitae
  suscipit tellus mauris. Curabitur vitae nunc sed velit dignissim.
  """

  def generate_random_text do
    @lorem_ipsum
    |> String.replace("\n", " ")
    |> String.split(" ")
    |> Enum.shuffle()
    |> Enum.reduce_while([], fn elem, acc ->
      it = acc ++ [elem]

      it
      |> Enum.join(" ")
      |> String.length()
      |> then(fn length ->
        if length > 160 do
          {:halt, it}
        else
          {:cont, it}
        end
      end)
    end)
    |> Enum.join(" ")
  end
end
