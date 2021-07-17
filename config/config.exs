# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :surface_change_tracking, SurfaceChangeTrackingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dD1M2fFQTc/XZ2u1X7QkEC0Q1VkN9U9DuFaccuN/YKbogxCetuPXltAwzYOIRH+X",
  render_errors: [view: SurfaceChangeTrackingWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SurfaceChangeTracking.PubSub,
  live_view: [signing_salt: "6YzgWIUT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
