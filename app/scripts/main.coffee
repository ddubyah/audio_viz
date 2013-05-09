require.config
  paths:
    jquery: "../components/jquery/jquery"
    sketch: "../components/sketch.js/js/sketch.min"
    bootstrap: "vendor/bootstrap"
    dancer: "vendor/dancer.min"

  shim:
    bootstrap:
      deps: ["jquery"]
      exports: "jquery"

    dancer:
      exports: "Dancer"

    sketch: 
      exports: "Sketch"

require ["viz", "jquery", "dancer", "bootstrap"], (Viz, $, Dancer) ->
  "use strict"
  
  $ ->
    viz = new Viz()
