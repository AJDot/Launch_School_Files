=begin
  Build a better playlist.

  A purely random shuffle just doesn't quite seem...mixed up enough.
  (Random and mixed up are not at all the same thign. Random is total clumpy.)


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
music_names = Dir['/media/ajdot/Barracuda/Users/Alex/Music/iTunes/iTunes Media/Music/{Aqualung,Guster,Angels & Airwaves}/**/*.m4a']

# shuffle the list
music_names_shuffled = shuffle music_names

filename = 'new_playlist_better.m3u'
File.open filename, 'w' do |f|
  music_names_shuffled.each do |name|
    f.write name + "\n"
  end
end

puts 'Done!'
