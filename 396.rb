require "rubygems"
require "bundler/setup"
# require your gems as usual
Bundler.require

require 'thread'

class Integer
  def to_base(base=10)
    return [0] if zero?
    raise ArgumentError, 'base must be greater than zero' unless base > 0
    num = abs
    return [1] * num if base == 1
    [].tap do |digits|
      while num > 0
        digits.unshift num % base
        num /= base
      end
    end
  end
end

def goodstein(m)
	n = 1
	gp = 1
	
	def check(n, m)
		print m.to_base(n), n
		m = m.to_base(n).reverse!.each_with_index.inject(0) { |num, (base, index)| num += base * (n+1)**(index) } - 1
	end

	50.times do
		n += 1
		m = check(n, m)
	end
	n - 1
end
thread_slices = [[1,6,11],[2,7,12],[3,8,13],[4,9,14],[5,10,15]]
results = Parallel.map(thread_slices) do |slice|
	sum = 0
	slice.each do |n|
		mutex = Mutex.new
		Thread.new do
			m = goodstein(n)
			mutex.synchronize do
				sum += m
			end
		end
	end
	main, *threads = Thread.list
		threads.each do |t|
	t.join
	p sum
end
end

p results