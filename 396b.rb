require_relative 'parallel'
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
    i = 2*(i+1)%1000000000
    p i
  end
  i 
end

def functionx(x,y,z,i)
  i = functiony(y,z,i)+1
  x.times do
    i = functiony(i,i,i)+1
    p i
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

thread_slices = [[1,6],[2,7],[3],[4],[5,8]]
# thread_slices = [[1,6],[2,7],[3],[4],[5]]

results = Parallel.map(thread_slices) do |slice|
  sum = 0
  slice.each do |m|
    mutex = Mutex.new
    Thread.new do
      m = m.to_base(2).reverse!
      m = functionw(m[3]||=0,m[2]||=0,m[1]||=0,m[0],1) -1
      mutex.synchronize do
        sum += m
      end
    end
    main, *threads = Thread.list
    threads.each do |t|
      t.join
    end
    sum
  end
  sum
end

p results.inject{|sum,x| sum + x }


