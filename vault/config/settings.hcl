ui = {{cfg.server.ui}}

storage "{{cfg.backend.storage}}" {
  path = "{{pkg.svc_data_path}}/{{cfg.backend.path}}"
}

listener "{{cfg.listener.type}}" {
  address = "{{cfg.listener.location}}:{{cfg.listener.port}}"
  tls_disable = {{cfg.listener.tls_disable}}
}
