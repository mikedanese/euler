require 'thread'
require 'debug'

array =*(0..40)
mutex = Mutex.new
final_array = []
thread_array=*(0..5)

for i in 0..5
   if !array.empty?
      thread_array[i] = Thread.new do
         number = array.pop
         a = 1
         for i in 0..number do
            a = number * a
            debugger
            a = a.to_s[-10,10].to_i if a < 10000000000
         end
         mutex.synchronize do            
            final_array << a
         end
      end
   else
      Thread.current.exit
   end
end

thread_array.each do |t|
   t.join
end

p final_array