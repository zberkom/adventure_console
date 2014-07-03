def typewriter(text)
  text.each_char do |letter|
      print letter
      sleep 0.01
  end
  print "\n" 
  text
end

def generate_save_file(file_name, stuff)
  data = {
    file: file_name,
    stuff: stuff
  }.to_yaml

  save_file = File.new("save.yml", "w")
  save_file.puts(data)
  save_file.close
end

def has_save_file?
  File.exists?("save.yml")
end

def ask_whether_to_continue_with_save_file
  puts "Do you want to continue with your saved game? (y/n)"
  answer = gets.chomp
  
  if answer == "y"
    saved = YAML.load File.read('save.yml')
    @stuff = saved[:stuff]
    display_chapter(saved[:file])
  else
    display_chapter("start.yml")
  end
end

def display_chapter(file_name)
  generate_save_file(file_name, @stuff)

  file_location = File.expand_path(File.dirname(__FILE__) + "/story/#{file_name}")
  file = File.read file_location
  chapter = YAML.load file

  typewriter chapter["title"]
  typewriter chapter["description"]

  if chapter["stuff"].any?
    items = []
    chapter["stuff"]["options"].each_with_index do |item, number|
      typewriter "#{number + 1}) #{item}"
      items[number + 1] = item
    end

    print ">"

    selected_numbers = gets.gsub("\n", "").split(",").map(&:to_i)
    abort chapter["stuff"]["limit_message"] if selected_numbers.size > chapter["stuff"]["limit"]

    selected_numbers.each do |item_number|
      @stuff << items[item_number] if items[item_number]
    end

    puts "Your inventory is now: #{@stuff}"
  end

  chapter["questions"].each do |question_data|
    question = Question.new(question_data)
    next_file = question.display!

    if next_file
      display_chapter(next_file)
      break
    end
  end
end
