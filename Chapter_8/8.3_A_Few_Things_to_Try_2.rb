=begin
  Table of contents, revisited.
  Rewrite your table of contents program on page 32. Start the program with an
   array holding all of the information for your table of contents (chapter
   names, page numbers, and so on). Then print out the information from the
   array in a beautifully formatted table of contents.
=end

array = [['Getting Started',1],['Numbers',9],['Letters',13]]

line_width = 30
total_line_width = 40

puts 'Table of Contents'.center(total_line_width)
array.each_with_index do |chapter, i|
  name, page = chapter
  num = i + 1
  puts "Chapter #{num}:  #{name}".ljust(line_width) + "page #{page}"
end
