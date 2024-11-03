defmodule AirbnbFeatures.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AirbnbFeaturesWeb.Telemetry,
      AirbnbFeatures.Repo,
      {DNSCluster, query: Application.get_env(:airbnb_features, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AirbnbFeatures.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AirbnbFeatures.Finch},
      # Start a worker by calling: AirbnbFeatures.Worker.start_link(arg)
      # {AirbnbFeatures.Worker, arg},
      # Start to serve requests, typically the last entry
      AirbnbFeaturesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AirbnbFeatures.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AirbnbFeaturesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
