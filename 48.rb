require 'thread'

array =*(1..1000)
mutex = Mutex.new
final_array = []
thread_array=*(0..3)

thread_array.each do |i|
   thread_array[i] = Thread.new do
      until array.empty?
         a = 1
         n = 1
         mutex.synchronize do
            n = array.pop
         end
         for i in 1..n do
            a = n * a
            a = a.to_s[-10,10].to_i if a > 10000000000
         end
         mutex.synchronize do            
            final_array << a
         end
      end
   end
end

main, *threads = Thread.list
threads.each do |t|
   t.join
end
sum = final_array.inject{|sum,x| sum + x }.to_s[-10,10].to_i
p sum