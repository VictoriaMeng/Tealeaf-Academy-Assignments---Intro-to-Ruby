def say(msg)
  puts "=> #{msg}"
end

say "Enter a number."
num1 = gets.chomp
until num1 == num1.to_i.to_s
    say "That's not a number! Please enter a number."
    num1 = gets.chomp
end

say "Enter a second number."
num2 = gets.chomp
until num2 == num2.to_i.to_s
    say "That's not a number! Please enter a number."
    num2 = gets.chomp
end

menu = {Add: 1, Subtract: 2, Multliply: 3, Divide: 4}
menu.each { |k, v| say "Press '#{v}' to #{k}." }

op = gets.chomp
until op == op.to_i.to_s && op.to_i.between?(1,4) == true
  say "Please enter a number between 1 and 4."
  op = gets.chomp
end

case op
when '1'
  say "#{num1.to_f} + #{num2.to_f} = #{num1.to_f + num2.to_f}"
when '2'
  say "#{num1.to_f} - #{num2.to_f} = #{num1.to_f - num2.to_f}"
when '3'
  say "#{num1.to_f} * #{num2.to_f} = #{num1.to_f * num2.to_f}"
when '4'
  say "#{num1.to_f} / #{num2.to_f} = #{num1.to_f / num2.to_f}"
end
  
  
 
