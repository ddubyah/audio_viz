define [
	'jquery'
	'underscore'
	'dancer'
	'sketch'
	'./particle'
], ($, _, Dancer, Sketch, Particle)->
	'use strict'
	Vis = null

	AUDIO_TRACK = 'http://dwmedia.s3.amazonaws.com/audio/aint_nothing'
	# AUDIO_TRACK = 'http://dwmedia.s3.amazonaws.com/audio/zircon_devils_spirit'
	COLOURS = [ '#A7DBD8', '#F00', '#FF4A00', '#FF7B00', '#FF9A00', '#FFD000', '#FFTDFDF' ]
	TWO_PI = Math.PI * 2

	class Viz
		@run: ->
			console.log "Running viz"


		constructor: ->
			@_bindControls()
			@_setupAudio()
			@_setupSketch()
			@particles = []

		_setupAudio: ->
			@dancer = new Dancer()
			@dancer.load src: AUDIO_TRACK, codecs: ['mp3', 'ogg']
			@dancer.bind 'loaded', @_ready

			console.log "Creating kick"
			vis = this 

			@kick = @dancer.createKick
				threshold: 0.1
				onKick: (mag)->
					# vis._drawDot mag, 0
					vis._drawSpectrum()


		_setupSketch: ->
			@sketch = Sketch.create
				container: $('#sketch').get(0)
				retina: true
				autoclear: false

			@sketch.update = @_update

		_ready: (e)=>
			$('#play-btn i').toggleClass 'icon-white'
			@kick.on()

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
			@dancer.play()

		_pause: ->
			@dancer.pause()

		_fadeOut: =>
			@sketch.globalCompositeOperation  = 'source-over';
			@sketch.fillStyle = "rgba(34,34,34, 0.05)"
			@sketch.fillRect 0, 0, @sketch.canvas.width, @sketch.canvas.height

		_drawSpectrum: =>
			@_cleanGarbage()

			spectrum = @dancer.getWaveform()
			# console.log spectrum[0]
			for mag, index in spectrum
				# console.log "Drawing %s, %d", mag, index
				# @_drawDot mag, index
				@_spawn mag, index

		# _drawDot: (mag, offset=0)->			
		# 	# xo = @sketch.canvas.width / 2
		# 	col = _.first _.shuffle COLOURS
		# 	xo = 0
		# 	vo = @sketch.canvas.height 
		# 	size = Math.round(mag * vo)* 2

		# 	@sketch.globalCompositeOperation  = 'lighter';
		# 	@sketch.beginPath()
		# 	# @sketch.arc xo, vo, size, 0, TWO_PI
		# 	@sketch.arc xo+offset, vo-size, 5, 0, TWO_PI

		# 	@sketch.fillStyle = col
		# 	@sketch.fill()

		_cleanGarbage: ->
			@particles = _.filter @particles, (particle)->
				particle.alive is true

		_spawn: (mag, offset=0)->
			h = @sketch.canvas.height
			dv = Math.round mag * h
			col = @_getColour mag
			speed = Math.round mag * 20 + 5
			p = new Particle offset, h-dv, 5, 0, -speed, col
			@particles.push p
			# p.draw @sketch 

		_getColour: (mag)->
			i = Math.floor mag * COLOURS.length
			COLOURS[i]

		_update: =>
			@_fadeOut()
			for particle in @particles
				# console.log "drawing p"
				if particle.alive
					particle.move()
					particle.draw @sketch


