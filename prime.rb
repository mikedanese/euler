require "rubygems"
require "bundler/setup"
# require your gems as usual
Bundler.require

a = *(2..6000)

class Fixnum
	def prime1?
			("1" * self) !~ /^1?$|^(11+?)\1+$/
	end

	def prime2?
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

	def prime3?(k)
		return true if self == 2
		return false if self < 2 or self % 2 == 0
		d = self - 1
		s = 0
		while d % 2 == 0
			d /= 2
			s += 1
		end
		k.times do
			a = 2 + rand(self-4)
			x = (a**d) % self
			next if x == 1 or x == self-1
			for r in (1 .. s-1)
				x = (x**2) % self
				return false if x == 1
				break if x == self-1
			end
			return false if x != self-1
		end
		true  # probably
	end
end

# p primes = (1..100).find_all {|i| miller_rabin_prime?(i,10)}

result = Benchmark.compare_realtime(inner_iterations: 1, iterations: 10) {
	p primes = (1..1000000).find_all { |n| n.prime2? }
	p primes.length
}.with {
	p primes = (1..1000000).find_all { |n| n.prime1? }
	p primes.length
}

Benchmark.report_on result