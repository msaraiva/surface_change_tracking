defmodule SurfaceChangeTrackingWeb.SlotsLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, counter: 0)}
  end

  defp wrapper(assigns) do
    ~H"""
    <div>
      <%= render_block(@inner_block) %>
    </div>
    """
  end

  defp wrapper_with_arg(assigns) do
    ~H"""
    <div>
      <%= render_block(@inner_block, @value) %>
    </div>
    """
  end

  defp heading(assigns) do
    ~H"""
    <h1>
      <%= @title %>
    </h1>
    """
  end

  def render(assigns) do
    ~H"""
    <%= component(&wrapper_with_arg/1, value: "MY ARG") do %>
      <% arg -> %>
        <%= component(&heading/1, title: "AAA") %>

        <!--
          Wrapping components disables change tracking of all child components
          whenever the variable is used anywere inside that wrapper.
          This only happens in the inner wrapper, not in the outer wrapper_with_arg.
        -->
        <%= component(&wrapper/1) do %>
          <%= component(&heading/1, title: "BBB") %>
          <%= component(&heading/1, title: "CCC") %>
          <%= component(&heading/1, title: arg) %>
        <% end %>

        <%= component(&heading/1, title: arg) %>

        <div>
          <button phx-click="increment">
            Increment counter
          </button>
        </div>

        <p>
          Counter: <%= @counter %>
        </p>
    <% end %>
    """
  end

  def handle_event("increment", _params, socket) do
    {:noreply, assign(socket, :counter, socket.assigns.counter + 1)}
  end
end
