def say(msg)
  puts "=> #{msg}"
end

say "Enter a number."
num1 = gets.chomp

say "Enter a second number."
num2 = gets.chomp

menu = {Add: 1, Subtract: 2, Multliply: 3, Divide: 4}
menu.each { |k, v| say "Press '#{v}' to #{k}." }
op = gets.chomp

if op == '1'
  say "#{num1.to_f} + #{num2.to_f} = #{num1.to_f + num2.to_f}"
elsif op == '2'
  say "#{num1.to_f} - #{num2.to_f} = #{num1.to_f - num2.to_f}"
elsif op == '3'
  say "#{num1.to_f} * #{num2.to_f} = #{num1.to_f * num2.to_f}"
elsif op == '4'
  say "#{num1.to_f} / #{num2.to_f} = #{num1.to_f / num2.to_f}"
end
  
  
 
