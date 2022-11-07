defmodule Otce.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Otce.Repo,
      # Start the Telemetry supervisor
      OtceWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Otce.PubSub},
      # Start the Endpoint (http/https)
      OtceWeb.Endpoint
      # Start a worker by calling: Otce.Worker.start_link(arg)
      # {Otce.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Otce.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OtceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
