defmodule TtWeb.PostLive.PostComponent do
    use TtWeb, :live_component

    def render(assigns) do
        ~L"""
                
        <%= @post.username %>
        <%= @post.body %>

        <%= @post.reposts_count %>
        <%= @post.likes_count %>
        
        <%= live_patch "Edit", to: Routes.post_index_path(@socket, :edit, @post.id) %>
        <%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Tem certeza que deseja excluir post ?"] %>


        """
    end
end