class U

	class << self
		def carry
			Proc.new { |memo, a| a || memo }
		end

		def sum
			Proc.new { |memo, a| (a ? 1 : 0) + memo }
		end

		def identity
			Proc.new { |a| a }
		end
	end
end