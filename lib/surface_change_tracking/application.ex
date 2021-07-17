defmodule SurfaceChangeTracking.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SurfaceChangeTrackingWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SurfaceChangeTracking.PubSub},
      # Start the Endpoint (http/https)
      SurfaceChangeTrackingWeb.Endpoint
      # Start a worker by calling: SurfaceChangeTracking.Worker.start_link(arg)
      # {SurfaceChangeTracking.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SurfaceChangeTracking.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SurfaceChangeTrackingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
