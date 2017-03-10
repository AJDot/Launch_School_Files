=begin
  Build your own playlist.

  Building a playlist is easy. It's just a regular text file (no
  YAML required, even). Each line is a filename, like this:

  music/world/Steriolab--Margarine_Eclipse/track05.ogg

  What makes it a playlist? Well, you have to give the file teh .m3u
  extension, like playlist.m3u or something. And that's all a playlist is:
  a text file with an .m3u extension.

  So, have your program search for various music files and build youra playlist.
  Use your shuffle mthod on page 75 to mix up your playlist. Then check it
  out in your favorite music player (Winamp, MPlayer, and so on)!
=end


# The shuffle methods to randomize a list
def shuffle list

  shuffle_rec list, []
end
def shuffle_rec remaining, shuffled
  # if all have been shuffled, return the shuffled list
  if remaining.length <= 0
    return shuffled
  end
  # how many are left to shuffle?
  left = remaining.length
  # choose a random index to be the next item index
  next_item_idx = rand(left)
  new_arr = []

  # if the item index in remaining matches the random one, then add it
  # to the shuffled list
  # if not, add it to the new_arr which will become the new remaining list
  current_idx = 0
  remaining.each do |item|
    if current_idx == next_item_idx
      shuffled.push item
    else
      new_arr.push item
    end
    current_idx += 1
  end
  shuffle_rec new_arr, shuffled
end

# This is where the playlist will go.
Dir.chdir '/media/ajdot/Barracuda/Users/Alex/Programming-Local/GitHub Repositories/AJDot/Learn_to_Program_The_Facets_of_Ruby/git_ignore/MusicPlaylist'

# Look for music here
music_names = Dir['/media/ajdot/Barracuda/Users/Alex/Music/iTunes/iTunes Media/Music/Aqualung/**/*.m4a']

# shuffle the list
music_names_shuffled = shuffle music_names

filename = 'new_playlist.m3u'
File.open filename, 'w' do |f|
  music_names_shuffled.each do |name|
    f.write name + "\n"
  end
end

puts 'Done!'
