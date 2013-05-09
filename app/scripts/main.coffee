require.config
  paths:
    jquery: "../components/jquery/jquery"
    sketch: "../components/sketch.js/js/sketch.min"
    bootstrap: "vendor/bootstrap"
    dancer: "vendor/dancer.min"
    underscore: "../components/underscore/underscore-min"

  shim:
    bootstrap:
      deps: ["jquery"]
      exports: "jquery"

    dancer:
      exports: "Dancer"

    sketch: 
      exports: "Sketch"

    underscore:
      exports: "_"

require ["viz", "jquery", "dancer", "underscore", "bootstrap"], (Viz, $, _, Dancer) ->
  "use strict"
  
  $ ->
    viz = new Viz()
