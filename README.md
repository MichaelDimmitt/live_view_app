# LiveViewApp

To start your Phoenix server:
```bash
{
  brew install elixir;
  mix archive.install hex phx_new 1.4.11;
  mix phx.new live_view_app;
  mix ecto.setup;
  mix phx.server;
}
```
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

  Following steps for live view from phoenix docs, trying to build a generator task.

Website: hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html

If you get stuck check chris mccords demo implementation:
https://github.com/chrismccord/phoenix_live_view_example/

## Commands that need to be implemented one time.
```bash

## step 1
## mix.exs
  defp deps do
    [
      ...,
      {:phoenix_live_view, github: "phoenixframework/phoenix_live_view"}
    ]

## step 2
vi lib/live_view_app_web/endpoint.ex
+  @session_options [
+    store: :cookie,
+    key: "_app_web_key",
+    signing_salt: "kwdfu/1u"
+  ]
+  socket "/live", Phoenix.LiveView.Socket,
+    websocket: [connect_info: [session: @session_options]]

-  plug Plug.Session,
-    store: :cookie,
-    key: "_app_web_key",
-    signing_salt: "kwdfu/1u"
-
+  plug Plug.Session, @session_options

## step 3
## generate a live view signing salt, different from phoenix signing salt.
mix phx.gen.secret 32
## add live_view: [signing_salt: ...] to ... config/config.exs
 config :app_web, LiveViewWeb.Endpoint,
   live_view: [signing_salt: "sM/h9HbXVlCWtQ2B5f88DYjDtfO4630C" ],

## step 4
## assets/package.json
    "phoenix_html": "file:../deps/phoenix_html",
    "phoenix_live_view": "file:../deps/phoenix_live_view"

## this command step may need to be added in every html eex related to the live view.
## step 5
## You should define the CSRF meta tag inside the in <head> in your layout:
## <%= csrf_meta_tag() %>
## lib/live_view_app_web/templates/layout/app.html.eex
<head>
<%= csrf_meta_tag() %>
</head>
## step 6 - related to (step 5)
## assets/js/app.js

import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"
  let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}});
```
```bash
Hookup a router based live view using 'live'.
1) lib/live_view_app_web/router.ex:
     import Phoenix.LiveView.Router
     scope "/", LiveViewWeb do
     ...
       live "/thermostat", ThermostatLive


Hookup an inline template live view using live_render.
Hookup a controller live view using live_render
```

