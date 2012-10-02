require "rubygems"
require "bundler/setup"
# require your gems as usual
Bundler.require

require 'thread'

mutex = Mutex.new

num_of_threads = 4

a = *(-1000..1000)
b = a.product(a)


def is_prime (n)
	if n > 1
		("1" * n) !~ /^1?$|^(11+?)\1+$/
	else
		false
	end
end

def quadratic (n, b, c )
	n**2 + b*n + c
end

final_array = []
slice_size = b.size()/(num_of_threads)+1

thread_slices = b.each_slice(slice_size).inject([]) do |memo, slice|
	memo << slice
end

results = Parallel.map(thread_slices) do |slice|
	best_combo = slice.inject([1,1,1]) do |memo, var|
		n = 0
		while is_prime(quadratic(n,var[0],var[1]))
			n += 1
		end
		if memo[0] < n
			memo = [n,var[0],var[1]]
		end
		memo
	end
end


p results