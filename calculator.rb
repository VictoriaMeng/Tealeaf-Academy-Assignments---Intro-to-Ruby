def say(msg)
  puts "=> #{msg}"
end

say "Enter a number."
num1 = gets.chomp
until num1 == num1.to_i.to_s || num1 == num1.to_f.to_s
    say "That's not a number! Please enter a number."
    num1 = gets.chomp
end

say "Enter a second number."
num2 = gets.chomp
until num2 == num2.to_i.to_s || num2 == num2.to_f.to_s
    say "That's not a number! Please enter a number."
    num2 = gets.chomp
end

menu = {Add: 1, Subtract: 2, Multliply: 3, Divide: 4}
menu.each { |operation, button| say "Press '#{button}' to #{operation}." }

operator = gets.chomp
until operator == operator.to_i.to_s && operator.to_i.between?(1,4) == true
  say "Please select '1', '2', '3', or '4'."
  operator = gets.chomp
end

num1 = num1.to_f
num2 = num2.to_f

case operator
when '1'
  say "#{num1} + #{num2} = #{num1 + num2}"
when '2'
  say "#{num1} - #{num2} = #{num1 - num2}"
when '3'
  say "#{num1} * #{num2} = #{num1 * num2}"
when '4'
  say "#{num1} / #{num2} = #{num1 / num2}"
end
  
  
 
