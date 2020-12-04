[
  ## all available options with default values (see `mix check` docs for description)
  # parallel: true,
  # skipped: true,

  ## list of tools (see `mix check` docs for defaults)
  tools: [
    ## curated tools may be disabled (e.g. the check for compilation warnings)
    # {:compiler, false},

    ## ...or adjusted (e.g. use one-line formatter for more compact credo output)
    # {:credo, "mix credo --format oneline"},

    ## ...or reordered (e.g. to see output from ex_unit before others)
    # {:ex_unit, order: -1},

    ## custom new tools may be added (mix tasks or arbitrary commands)
    # {:my_mix_task, command: "mix release", env: %{"MIX_ENV" => "prod"}},
    # {:my_arbitrary_tool, command: "npm test", cd: "assets"},
    # {:my_arbitrary_script, command: ["my_script", "argument with spaces"], cd: "scripts"}

    # Disabled Config.HTTPS check as we leave https termination to k8s ingresses
    # Disabled Config.CSP as the static analysis nature of sobelow doesn't 'see' that we add the relevant
    # content security policy in the separate plug RemoteWeb.Plug.Csp
    # Disabled Config.CSWH as according to https://hexdocs.pm/phoenix/Phoenix.Transports.WebSocket.html origin
    # checking is the default.
    {:compiler, "mix compile --ignore-module-conflict --warnings-as-errors --force"}
  ]
]
