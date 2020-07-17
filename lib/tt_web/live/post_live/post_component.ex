defmodule TtWeb.PostLive.PostComponent do
    use TtWeb, :live_component

    def render(assigns) do
        ~L"""
        <div class="card">
        <div class="card-header">
          <%= @post.username %>
        </div>
        <div class="card-body">
          <blockquote class="blockquote mb-0">
            <p><%= @post.body%></p>
            <cite title="Source Title">
            Curtidas : <b><%= @post.reposts_count %></b>
            Compartilhamentos : <b><%= @post.likes_count %></b>
          </cite>
            <footer class="blockquote-footer">
              <%= live_patch "Edit", to: Routes.post_index_path(@socket, :edit, @post.id) %>
              <%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Tem certeza que deseja excluir post ?"] %>
          </blockquote>
            </footer>
        </div>
      </div>

        """
    end
end