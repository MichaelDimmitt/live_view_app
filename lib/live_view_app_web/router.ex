defmodule LiveViewAppWeb.Router do
  use LiveViewAppWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveViewAppWeb do
    pipe_through :browser
    live "/thermostat", ThermostatLive

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveViewAppWeb do
  #   pipe_through :api
  # end
end
