require "yaml"
require_relative "question"
require_relative "lib"

@stuff = []

if has_save_file?
  ask_whether_to_continue_with_save_file
else
  display_chapter("start.yml")
end
