########################
# INCOMPLETE
########################

=begin
  Build a better playlist.

  A purely random shuffle just doesn't quite seem...mixed up enough.
  (Random and mixed up are not at all the same thign. Random is total clumpy.)

=end

=begin

  A better way would be mix more carefully and on every level (artist, album).

  Find similar song (like on the same CD), mix them up, and spread them out as
  far away from each other as I can in teh next grouping (like songs by the
  same artist). Then do the same for teh next level up (like genre if it exists)

=end

def music_shuffle filenames
  songs_and_paths = filenames.map do |s|
    [s, s.split('/')]   # [song, path]
  end

  tree = {:root => []}

  # put each song into the tree
  insert_into_tree

  # ##################
  # NEED TO LEARN PROC
  # ##################
end

# This is where the playlist will go.
Dir.chdir '/media/ajdot/Barracuda/Users/Alex/Programming-Local/GitHub Repositories/AJDot/Learn_to_Program_The_Facets_of_Ruby/git_ignore/MusicPlaylist'

# Look for music here
music_names = Dir['/media/ajdot/Barracuda/Users/Alex/Music/iTunes/iTunes Media/Music/{Aqualung,Guster,Angels & Airwaves,Ben Folds}/**/*.m4a']

filename = 'new_playlist_better.m3u'
File.open filename, 'w' do |f|
  music_shuffle(music_names).each do |name|
    f.write name + "\n"
  end
end

puts 'Done!'
