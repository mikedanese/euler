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
	result = 1
	until result == 0
		n += 1
		result = (good2 = proc do |n, m|
			if n == 1
				m
			else
				m = good2[n-1, m].to_base(n).reverse!.each_with_index.inject(0) { |num, (base, index)| num += base * (n+1)**(index) } - 1
			end
		end)[n, m]
		p n
	end
	n - 1
end

p (1..8).inject(0) { |sum, num| sum += goodstein(num)}