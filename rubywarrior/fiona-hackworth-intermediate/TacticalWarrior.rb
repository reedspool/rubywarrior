load 'SmartWarrior.rb'

class TacticalWarrior < SmartWarrior

	def method_missing(meth, *args)
		if meth.match /\!/
			if @have_played
				return
			else
				@have_played = true
				super
			end
		else
			super
		end
	end

	def bind_danger!
		bind!(touching_danger) if touching_danger
	end

	def rescue_captive!
		rescue!(touching_captive) if touching_captive
	end

	def attack_danger!
		attack!(touching_danger) if touching_danger
	end

end