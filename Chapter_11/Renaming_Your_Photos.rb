# This is where the original pictures are stored.
Dir.chdir('/media/ajdot/Barracuda/Users/Alex/Programming-Local/GitHub Repositories/AJDot/Learn_to_Program_The_Facets_of_Ruby/git_ignore/PictureInbox')

# First we find all of the pictures to be moved.
pic_names = Dir['/media/ajdot/Barracuda/Users/Alex/Programming-Local/GitHub Repositories/AJDot/Learn_to_Program_The_Facets_of_Ruby/git_ignore/Pics_To_Move/**/*.dng']

puts 'What would you like to call this batch?'
batch_name = gets.chomp

puts
print "Downloading #{pic_names.length} files:  "

# This will be our counter. We'll start at 1.
pic_number = 1

pic_names.each do |name|
  print '.' # this is the 'progress bar'

  new_name = if pic_number < 10
    "#{batch_name}0#{pic_number}.dng"
  else
    "#{batch_name}#{pic_number}.dng"
  end

  File.rename name, new_name

  pic_number = pic_number + 1
end

puts # so we aren't on our progress bar line
puts 'Done!'
