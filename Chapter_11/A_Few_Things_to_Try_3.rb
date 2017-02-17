=begin
  Build a better playlist.

  A purely random shuffle just doesn't quite seem...mixed up enough.
  (Random and mixed up are not at all the same thign. Random is total clumpy.)

=end


# shuffle the list
def music_shuffle filenames
  # We don't want a perfectly random shuffle, so let's
  # instead do a shuffle like card-shuffling. Let's
  # shuffle the "deck" twice, then cut it once. That's
  # not enough times to make a perfect shuffle, but it
  # does mix things up a bit.
  # Before we do anything, let's actually *sort* the
  # input, since we don't know how shuffled it might
  # already be, and we don't want it to be *too* random.

  filenames = filenames.sort
  len       = filenames.length

  # Now we shuffle twice
  2.times do
    l_idx = 0         # index of next card in left pile
    r_idx = len / 2   # index of next card in right pile
    shuf = []
    # NOTE: If we have an odd number of "cards",
    #       then the right rill will be larger.

    while shuf.length < len
      if shuf.length % 2 == 0
        # take card from right pile
        shuf.push(filenames[r_idx])
        r_idx = r_idx + 1
      else
        # take card from left pile
        shuf.push(filenames[l_idx])
        l_idx = l_idx + 1
      end
    end
    filenames = shuf
  end

  # And cut the deck.
  arr = []
  cut = rand(len) # index of card to cut at
  idx = 0

  while idx < len
    arr.push(filenames[(idx+cut)%len])
    idx = idx + 1
  end
  arr
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
