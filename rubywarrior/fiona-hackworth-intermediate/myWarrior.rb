require 'forwardable'

load 'util.rb'

class MyWarrior
	attr_accessor :war

	def initialize(war)
		@war = war
	end

	def max_health
		20
	end

	def dirs
		[ :forward, :left,
			:backward, :right].reverse
	end

	def unfilled
		w.health < w.max_health
	end

	# Otherwise pass through to our lovely host
	def method_missing(meth, *args)
		if @war.respond_to?(meth)
			@war.send(meth, *args)
		else
			super
		end
	end
end