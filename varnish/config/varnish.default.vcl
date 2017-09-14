vcl 4.0;

backend default {
  .host = "{{cfg.backend.host}}";
  .port = "{{cfg.backend.port}}";
  .max_connections = {{cfg.backend.max_connections}};
}
