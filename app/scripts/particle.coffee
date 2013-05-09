define [
	'underscore'
], (_)->
	TWO_PI = Math.PI * 2
	BOUNCE = 0.9
	COLOURS = [ '#69D2E7', '#A7DBD8', '#E0E4CC', '#F38630', '#FA6900', '#FF4E50', '#F9D423' ]

	###*
	 * Particle
	###
	class Particle
		_bounce: (d)->
			d * -1

		constructor: (@x, @y, @radius=50, @vx=0, @vy=0, col)->
			# console.log 'new particle'
			# @colour = _.first _.shuffle(COLOURS)
			@colour = col or  '#FFTDFDF'
			@g = 0.5
			@alive = true
			@drag = 0.995

		move: ->
			@vy += @g
			# @vx *= @drag
			# @vy *= @drag
			@x += @vx
			@y += @vy

			@radius *= 0.8
			@alive = @radius > 0.5

		draw: (ctx)->
			# console.log "Drawing new particle: %d, %d, %d, %s", @x, @y, @radius, '#69D2E7'
			if @y >= ctx.height
				@y = ctx.height
				@vy = @_bounce @vy

			if @x >= ctx.width
				@x = ctx.width
				@vx = @_bounce @vx

			if @x <= 0
				@x = 0
				@vx = @_bounce @vx


			ctx.beginPath()
			ctx.arc @x, @y, @radius, 0, TWO_PI 
			ctx.fillStyle = @colour
			ctx.fill()