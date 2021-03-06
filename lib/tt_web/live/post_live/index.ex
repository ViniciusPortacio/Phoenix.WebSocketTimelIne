defmodule TtWeb.PostLive.Index do
  use TtWeb, :live_view

  alias Tt.TimeLine
  alias Tt.TimeLine.Post

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: TimeLine.subscribe() #config do websocket
    {:ok, assign(socket, :posts, list_posts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, TimeLine.get_post!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = TimeLine.get_post!(id)
    {:ok, _} = TimeLine.delete_post(post)

    {:noreply, assign(socket, :posts, list_posts())}
  end

  #configs do websocket
  @impl true
  def handle_info({:post_created, post}, socket) do
    {:noreply, update(socket, :posts, fn posts -> [post | posts] end )}
  end

  defp list_posts do
    TimeLine.list_posts()
  end
end
