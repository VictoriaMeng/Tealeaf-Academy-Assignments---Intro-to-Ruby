def say(msg)
  puts "=> #{msg}"
end

say "Enter a number."
number_01 = gets.chomp
until number_01 == number_01.to_i.to_s || number_01 == number_01.to_f.to_s
    say "That's not a number! Please enter a number."
    number_01 = gets.chomp
end

say "Enter a second number."
number_02 = gets.chomp
until number_02 == number_02.to_i.to_s || number_02 == number_02.to_f.to_s
    say "That's not a number! Please enter a number."
    number_02 = gets.chomp
end

menu = {Add: 1, Subtract: 2, Multliply: 3, Divide: 4}
menu.each { |operation, button| say "Press '#{button}' to #{operation}." }

operator = gets.chomp
until operator == operator.to_i.to_s && operator.to_i.between?(1,4) == true
  say "Please select '1', '2', '3', or '4'."
  operator = gets.chomp
end

number_01 = number_01.to_f
number_02 = number_02.to_f

case operator
when '1'
  say "#{number_01} + #{number_02} = #{number_01 + number_02}"
when '2'
  say "#{number_01} - #{number_02} = #{number_01 - number_02}"
when '3'
  say "#{number_01} * #{number_02} = #{number_01 * number_02}"
when '4'
  say "#{number_01} / #{number_02} = #{number_01 / number_02}"
end
  
  
 
