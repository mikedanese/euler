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

def functionz(i,z)
  p 'z'
  i+z
end

def functiony(y,z,i)
  i = functionz(i,z)
  y.times do 
    i = 2*(i+1)
    p 'y' 
  end
  i
end

def functionx(x,y,z,i)
  i = functiony(y,z,i)+1
  x.times do
    i = functiony(i,i,i)+1
    p 'x'
  end
  i-1
end

def functionw(w,x,y,z,i)
  i = functionx(x,y,z,i)+1
  w.times do
    i = functionx(i,i,i,i)+1
    p 'w'
  end
  i-1
end

def goodstein(m)
  n = 1
  gp = 1
  
  def check(n, m)
    print m.to_base(n), n
    m = m.to_base(n).reverse!.each_with_index.inject(0) { |num, (base, index)| num += base * (n+1)**(index) } - 1
  end

  until m == 0
    n += 1
    m = check(n, m)
  end
  n - 1
end

thread_slices = [[1,6,11],[2,7,12],[3,8,13],[4,9,14],[5,10,15]]

results = Parallel.map(thread_slices) do |slice|
  sum = 0
  (1..8).each do |m|
    m = m.to_base(2).reverse!
    sum += functionw(m[3]||=0,m[2]||=0,m[1]||=0,m[0],1) -1
    sum
  end
  sum
end

p results


