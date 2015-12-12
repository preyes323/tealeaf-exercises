filename = 'my_file.txt'

File.new(filename, "w+")

File.open(filename, 'w') do |file|
  file.write "Hello, World!\n"
end

File.open(filename, 'w') do |file|
  file.write "Hello, Paolo!\n"
  3.times { file.write "Welcome!!!\n" }
  file.write "Testing testing\n"
end

File.open(filename, 'a+') do |file|
  file.write "I'm adding content to the file\n"
end

file_contents = File.readlines(filename).each_with_index do |content, idx|
  puts "line #{idx + 1}: #{content}"
end
