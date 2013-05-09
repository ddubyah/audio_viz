define [
	'jquery'
	'dancer'
	'sketch'
], ($, Dancer, Sketch)->
	'use strict'
	Vis = null

	class Viz
		@run: ->
			console.log "Running viz"


		constructor: ->
			@_bindControls()

		_bindControls: ->
			viz = this

			$('#play-btn').click (e)->
				e.preventDefault()
				if $(this).hasClass 'play'
					viz._play()
				else
					viz._pause()
				
				$(this).toggleClass "play pause"
				$(this).find('i').toggleClass 'icon-play icon-pause'

		_play: ->
			console.log "Play!"

		_pause: ->
			console.log "Pause!"


