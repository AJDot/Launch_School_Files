=begin
  # Safer picture downloading.
  Adapt the picture-downloading/file-renaming program to your computer by
  adding some safety features to make sure you never overwrite a file.
  A few methods you might find useful are File.exist? (pass it a filename,
  and it will return true or false) and exit (like if return and Napoleon
  had a baby -- it kills your program right where it stands;
  this is good for spitting out an error message and then quitting).
=end

# This is where the pictures will be moved to.
Dir.chdir('/media/ajdot/Barracuda/Users/Alex/Programming-Local/GitHub Repositories/AJDot/Learn_to_Program_The_Facets_of_Ruby/git_ignore/PictureInbox')

# First we find all of the pictures to be moved.
pic_names = Dir['/media/ajdot/Barracuda/Users/Alex/Programming-Local/GitHub Repositories/AJDot/Learn_to_Program_The_Facets_of_Ruby/git_ignore/Pics_To_Move/**/*.dng']

puts 'What would you like to call this batch?'
batch_name = gets.chomp

puts
print "Downloading #{pic_names.length} files:  "

# This will be our counter. We'll start at 1.
pic_number = 1

already_exist = []

pic_names.each do |name|
  print '.' # this is the 'progress bar'

  new_name = if pic_number < 10
    "#{batch_name}0#{pic_number}.dng"
  else
    "#{batch_name}#{pic_number}.dng"
  end

  # if file does not exist
  if File.exist?(new_name) == false
    File.rename name, new_name
  # if file already exists
  else
    already_exist << [name, new_name]
  end

  pic_number = pic_number + 1

end

puts # so we aren't on our progress bar line
puts 'Done!'
if already_exist.length > 0
  puts "#{already_exist.length} file(s) were not moved because they already exist: "
  already_exist.each do |old_loc, new_loc|
    puts "#{old_loc} was not moved to #{new_loc}"
  end
end
