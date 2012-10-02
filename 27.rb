require "rubygems"
require "bundler/setup"
# require your gems as usual
Bundler.require



class Fixnum
	def prime?
			("1" * self) !~ /^1?$|^(11+?)\1+$/ if self > 2
	end

	def prime1?
		return false if self < 2
		return true if self == 2 || self == 3
		return false if self%2 == 0 || self%3 == 0
		return true if self < 9
		upper = Math.sqrt(self).floor
		factor = 5
		until factor > upper
			return false if self%factor == 0 || self%(factor+2) == 0
			factor += 6
		end
		return true
	end
end

def quadratic (n, b, c )
	n**2 + b*n + c
end


a = *(-1000..1000)
b = *(2..1000)
c = a.product(b) 

final_array = []
slice_size = c.size()/4+1

thread_slices = c.each_slice(slice_size).inject([]) do |memo, slice|
	memo << slice
end

results = Parallel.map(thread_slices) do |slice|
	best_combo = slice.inject([1,1,1]) do |memo, var|
		n = 0
		while quadratic(n,var[0],var[1]).prime?
			n += 1
		end
		if memo[0] < n
			memo = [n,var[0],var[1]]
		end
		memo
	end
end


p results