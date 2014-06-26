require "yaml"

file_location = File.expand_path(File.dirname(__FILE__) + '/test.yml')
file = File.read file_location

yaml = YAML.load file
print yaml
