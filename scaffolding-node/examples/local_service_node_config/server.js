var config = require("config")

require("http").createServer(function (request, response) {
  response.end("Hello World\n");
}).listen(config.get("port"))

console.log("Server listening on " + config.get("port"));
