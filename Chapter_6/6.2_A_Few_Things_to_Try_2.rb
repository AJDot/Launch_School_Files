l_line_width = 20
r_line_width = 20
ch_line_width = 13
total_line_width = ch_line_width + l_line_width + r_line_width

ch_1_title = "Getting Started"
ch_1_pg = "1"
ch_2_title = "Numbers"
ch_2_pg = "9"
ch_3_title = "Letters"
ch_3_pg = "13"

puts 'Table of Contents'.center(total_line_width)
puts 'Chapter 1:  '.ljust(ch_line_width) + ch_1_title.ljust(l_line_width) + ('page ' + ch_1_pg).ljust(r_line_width)
puts 'Chapter 2:  '.ljust(ch_line_width) + ch_2_title.ljust(l_line_width) + ('page ' + ch_2_pg).ljust(r_line_width)
puts 'Chapter 3:  '.ljust(ch_line_width) + ch_3_title.ljust(l_line_width) + ('page ' + ch_3_pg).ljust(r_line_width)
