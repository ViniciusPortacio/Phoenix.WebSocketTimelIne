defmodule Tt.TimeLineTest do
  use Tt.DataCase

  alias Tt.TimeLine

  describe "posts" do
    alias Tt.TimeLine.Post

    @valid_attrs %{body: "some body", likes_count: 42, reposts_count: 42, username: "some username"}
    @update_attrs %{body: "some updated body", likes_count: 43, reposts_count: 43, username: "some updated username"}
    @invalid_attrs %{body: nil, likes_count: nil, reposts_count: nil, username: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TimeLine.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert TimeLine.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert TimeLine.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = TimeLine.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.likes_count == 42
      assert post.reposts_count == 42
      assert post.username == "some username"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeLine.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = TimeLine.update_post(post, @update_attrs)
      assert post.body == "some updated body"
      assert post.likes_count == 43
      assert post.reposts_count == 43
      assert post.username == "some updated username"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeLine.update_post(post, @invalid_attrs)
      assert post == TimeLine.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = TimeLine.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> TimeLine.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = TimeLine.change_post(post)
    end
  end
end
