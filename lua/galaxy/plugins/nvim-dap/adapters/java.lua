local dap = nvim.require("dap")

dap.adapters.java = function(callback)
  callback({
    type = "server",
    host = "127.0.0.1",
    port = 5005,
  })
end

dap.configurations.java = {
  {
    type = "java",
    request = "attach",
    name = "Attach to Java (5005)",
    hostName = "127.0.0.1",
    port = 5005,
  },
}

dap.configurations.kotlin = dap.configurations.java
