require 'mathn'

def curious_division  a, b
	aa = a
	aa = aa.to_s.split('')
	denominator = b.to_s.split('')
	numerator = aa.inject([]) do |num, s|
		index = denominator.index(s)
		if index.nil?
			num << s
		else
			denominator.delete_at(index)
		end
		num
	end
	numerator = numerator.join('').to_i
	denominator = denominator.join('').to_i
	[numerator, denominator]       
end

a = *(1..99)
b = a.product(a).inject([]) do |memo, n|
	memo << n if n[0]/n[1] < 1
	memo
end

curious_fractions = b.inject([]) do |cfa, n|
	f = n[0]/n[1]
	cf = curious_division(n[0],n[1])
	if cf[0] != 0 and cf[1] != 0 and (n[0].to_s.split('') & n[1].to_s.split('')).index('0').nil? and n[0] % 10 !=0 and cf[0]/cf[1] == n[0]/n[1] and "#{cf[0]}/#{cf[1]}" != "#{n[0]}/#{n[1]}"
		cfa << n[0]/n[1]
		p n
		p cf
	end
	cfa
end
p curious_fractions
product = curious_fractions.inject(1,:*)
p product