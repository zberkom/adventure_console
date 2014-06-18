#!usr/bin/ruby

# There are two ways to print text to the screen in Ruby.
#
# puts  - Prints out the text AND adds a new line (\n) to the end, so that the
#         next thing you puts will be on a new line.
#
# print - Prints out the text and DOES NOT put a new line (\n) at the end. This
#         means that when you print, the next print will put stuff on the same
#         line.
#
# For example:
#
#   puts "Hello"
#   puts "There"
#
# Prints out this:
#
#   Hello
#   There
#
# But this:
#
#   print "Hello"
#   print "There"
#
# Will do this:
#
#   HelloThere
#
# I'm going to write a function which takes advantage of the print function to
# make the text passed in type out slowly rather than appear all at once, like
# a typewriter.
def typewriter(text) # Name the method "Typewriter"
  # Loop through the text, printing out each letter in the sentence one by
  # one until we're done.
  text.each_char do |letter|
      print letter
      sleep 0.05 # Wait 5/100 of a second to print the next character.
  end
  print "\n" # Print a new line character to make this function act like puts.

  # Finally, return the text. In ruby, you don't have to type "return"
  # the last thing is automatically returned
  text
end

# I can now use this function two ways:
#
# 1. With parentheses: typewriter("Words to type")
# 2. Or without parentheses: typewriter "Words to type"
puts "STAR WARS!!!!"
typewriter %{You are a smuggler. Your crew has betrayed you, but still has enough of a
soft spot that they are not killing you. Instead, they decided that they would
abandon you on a desert moon in the outer rim, and give you 3 items from
your locker. Which items do you take?}

typewriter "1) Electronic Lock-Pick"
typewriter "2) Blaster"
typewriter "3) Concussion Rifle"
typewriter "4) Thermal Detonator"
typewriter "5) Personal Shield Generator"
typewriter "6) Grappling gun"

sleep 0.5 # Wait half a second before giving them the option to select stuff.

typewriter "Separate your selections with a comma:"
print ">"

stuff = []
answers = gets.gsub("\n", "").split(",")

# I can chain functions together.
# This is the same as abort(typewriter("Some words"))
abort typewriter(%{Your crew was surprised that you didn't listen to them when they said
you could only have 3 items. They shot you dead.}) if answers.size > 3

# This is one way to add stuff to an array in Ruby.
#
#   array = []
#   array << :lock_pick
#   array # => [:lock_pick]
#
# You can also use the Array#push function, though it doesn't look as cool.
#
#   array = []
#   array.push(:lock_pick)
#   array # => [:lock_pick]
stuff << :lock_pick           if answers.include?("1")
stuff << :blaster             if answers.include?("2")
stuff << :concussion_rifle    if answers.include?("3")
stuff << :thermal_detonator   if answers.include?("4")
stuff << :shield_generator    if answers.include?("5")
stuff << :grappling_gun       if answers.include?("6")

# Include variables in strings like this:
puts "You have this stuff: #{stuff}"

puts "--------------------------------------------"
puts "CHAPTER 1"
puts "In which you search for a way off this rock."
puts "--------------------------------------------"
puts %{You find yourself in an abandoned village, on a narrow, one-way street.
  Which way are going to go?}

  puts "1) Go up the street."
  puts "2) Go down the street."

print ">"

# Since we repeat this answer checking code a lot, wouldn't it be nice if
# we could make it simpler? We can do just that with a custom function!

def abort_if(answer, wrong_answer, abort_message)
  if answer == "#{wrong_answer}\n" # Add in the \n stuff so we don't have to type every time
      abort abort_message
  end
end

answer = gets
abort_if answer, 1, "You are shot from out of nowhere by a roaming band of Tusken Raiders. Bye Bye."

puts "You walk down the street and find yourself in front of a warehouse.
 Do you want to go in or continue of your way?"

  puts "1) Go into the warehouse."
  puts "2) Continue on your way."

print ">"
answer = gets
abort_if answer, 2, %{You come around the building and are run over by a raging bantha! Start over :(}

puts "You see that the Warehouse is covered in junk and debris but in the back corner
you see some sort of aircraft and investigate it."

puts "1) Cut the green wire."
puts "2) Cut the red wire."
print ">"

answer = gets
abort_if answer, 1, "The ship blew up and you died."

puts "The ship powered up and you open the sliding door. Just outside the door, 6 battle droids 
are standing outside ready to shoot. Do you want to,"
puts "1) Shoot them with the space ship."
puts "2) Hide behind the wall."
print ">"

answer = gets
abort_if answer, 1, "You couldn't reach the ship in time. They shoot you in the back."

puts "The droids come around the corner and surround you. You can,"
puts "1) Burst through them and try to escape in the ship."
puts "2) Shoot them with your blaster."
puts "3) Surrender."
print ">"

answer = gets
abort_if answer, 2, "Some droids stayed outside and shoot you as you pass them. Dead again!"

answer = gets
abort_if answer, 3, "Something goes wrong at the droid control center. They go against the code and detonate the entire building."

puts "You successfully elude their fire and shut the cockpit. Do you want to"
puts"1) Shoot them with your cannons."
puts"2) Fly away immediately."
print ">"

answer = gets
abort_if answer, 1, "You used up the little power you had and were unable to escape the blow you and the ship sky high. MISSION FAILED!"
abort_if answer, 2, "You barely escape with your life. Congradulations! You have successfully gotten off this rock!"