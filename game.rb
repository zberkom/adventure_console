#!usr/bin/ruby
  
# There are two ways to print text to the screen in Ruby.
#
# typewriter  - Prints out the text AND adds a new line (\n) to the end, so that the
#         next thing you typewriter will be on a new line.
#
# print - Prints out the text and DOES NOT put a new line (\n) at the end. This
#         means that when you print, the next print will put stuff on the same
#         line.
#
# For example:
#
#   typewriter "Hello"
#   typewriter "There"
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
      sleep 0.01 # Wait 5/100 of a second to print the next character.
  end
  print "\n" # Print a new line character to make this function act like typewriter.

  # Finally, return the text. In ruby, you don't have to type "return"
  # the last thing is automatically returned
  text
end

def abort_if(answer, wrong_answer, abort_message)
  if answer == "#{wrong_answer}\n" # Add in the \n stuff so we don't have to type every time
      abort abort_message
  end
end


# I can now use this function two ways:
#
# 1. With parentheses: typewriter("Words to type")
# 2. Or without parentheses: typewriter "Words to type"
typewriter "STAR WARS!!!!"
typewriter %{You are a smuggler. Your crew has betrayed you, but still has enough of a
soft spot that they are not killing you. Instead, they decided that they would
abandon you on a desert moon in the outer rim, and give you 3 items from

your locker. Which items do you take?}

   typewriter "1) Electronic Lock-Pick"
   typewriter "2) Blaster"
   typewriter "3) Concussion Rifle"
   typewriter "4) Thermal Detonator"
   typewriter "5) Titanium Reinforced armor"
   typewriter "6) Grappling gun"

sleep 0.5 # Wait half a second before giving them the option to select stuff.

  typewriter "Separate your selections with a comma:"
  print ">"

STUFF = []
answers = gets.gsub("\n", "").split(",")

# I can chain functions together.
# This is the same as abort(typewriter("Some words"))
abort typewriter(%{Your crew was surprised that you didn't listen to them when they said
you could only have 3 items. They shot you dead.}) if answers.size > 3

class Question
  def initialize(text, options)
    @text = text
    @options = options
  end
  
  def display!
    typewriter @text
    
    @options.each_with_index do |option, index|
      if option[:required_stuff].nil? || ::STUFF.include?(option[:required_stuff])
        option[:number] = index + 1
        typewriter "#{option[:number]}) #{option[:text]}"
      end
    end
    print ">"
    
    answer = gets.to_i
    selected_option = @options.find { |o| o[:number] == answer }

    if selected_option.nil?
      puts "You selected an invalid option."
      display!
    else
      if selected_option[:correct] == false
        typewriter(selected_option[:death] || "You died.")
        abort
      end
    end
  end
end

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
STUFF << :lock_pick           if answers.include?("1")
STUFF << :blaster             if answers.include?("2")
STUFF << :concussion_rifle    if answers.include?("3")
STUFF << :thermal_detonator   if answers.include?("4")
STUFF << :shield_generator    if answers.include?("5")
STUFF << :grappling_gun       if answers.include?("6")

# Include variables in strings like this:
typewriter "You have this stuff: #{STUFF}"

typewriter "--------------------------------------------"
typewriter "CHAPTER 1"
typewriter "In which you search for a way off this rock."
typewriter "--------------------------------------------"

#First Question
Question.new("You find yourself in an abandoned village, on a narrow, one-way street. Which way are going to go?", [{
  text: "Go up the street.",
  correct: false,
  death: "You are shot from out of nowhere by a roaming band of Tusken Raiders. Bye Bye."
}, {
  text: "Go down the street.",
  correct: true
}]).display!

#Second Questions
Question.new("You walk down the street and find yourself in front of a warehouse. Do you want to go in or continue of your way?", [{
  text: "Go into the warehouse.",
  correct: true
}, {
  text: "Continue on your way.",
  correct: false,
  death: "You come around the building and are run over by a raging bantha! Start over :("
}]).display!

#Third Question
Question.new("You see that the Warehouse is covered in junk and debris but in the back corner you see some sort of spacecraft and investigate it.", [{
  text: "Cut the green wire.",
  correct: false,  
  death: "The ship blew up and you died."
},{
  text: "Cut the red wire.",
  correct: true
}]).display!

#Fourth Question
Question.new("The ship powered up and you open the sliding door. Just outside the door, 6 battle droids are standing outside ready to shoot. Do you want to,", [{
  text: 'Shoot them with the space ship.',
  correct: false,
  death: "You couldn't reach the ship in time. They shoot you in the back."
}, {
  text: "Hide behind the wall.",
  correct: true
}]).display!

Question.new("The droids come around the corner and surround you. You can,", [{
  text: "Burst through them and try to escape in the ship.",
  correct: true
}, {
  text: "Surrender.",
  correct: false,
  death: "Something goes wrong at the droid control center. They go against the code and detonate the entire building."
}, {
  text: "Shoot them with your blaster.",
  correct: false,
  required_stuff: :blaster,
  death: "Some droids stayed outside and shoot you as you pass them. Dead again!"
}]).display!
  
Question.new("You successfully elude their fire and shut the cockpit. Do you want to", [{
  text: "Shoot them with your cannons.",
  correct: false,
  death: "You used up the little power you had and were unable to escape. They blow you and the ship sky high. MISSION FAILED!"
}, {
  text: "Fly away immediately.",
  correct: true
}]).display!
  
puts "You barely escape with your life. Congratulations! You have successfully gotten off this rock!"