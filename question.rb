class Question
  def initialize(data)
    @text = data["text"]
    @options = data["options"]
  end
  
  def display!
    typewriter @text
    
    @options.each_with_index do |option, index|
      if option["required_stuff"].nil? || ::STUFF.include?(option["required_stuff"])
        option["number"] = index + 1
        typewriter "#{option["number"]}) #{option["text"]}"
      end
    end
    print ">"
    
    answer = gets.to_i
    selected_option = @options.find { |o| o["number"] == answer }

    if selected_option.nil?
      puts "You selected an invalid option."
      display!
    else
      if selected_option["death"]
        typewriter(selected_option["death"])
        abort
      end
    end

    selected_option["goto_file"]
  end
end

