require 'thread'

array =*(0..4)
mutex = Mutex.new
final_array = []
thread_array=*(0..5)

for i in 0..5
   mutex.synchronize do
      number = array.pop
   end
   while !array.empty?
      Thread.new do
         number = array.pop
         a = 1
         for i in 0..number do
            a = number * a
            a = a.to_s[-10,10].to_i if a > 10000000000
         end
         mutex.synchronize do            
            final_array << a
            number = array.pop
         end
         Thread.current.kill
      end
   end
end


p final_array