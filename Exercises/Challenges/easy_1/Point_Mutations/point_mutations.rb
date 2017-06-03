class DNA
  def initialize(sequence)
    @sequence = sequence
  end

  def hamming_distance(test_sequence)
    shortest_sequence = [@sequence, test_sequence].min_by(&:size)

    shortest_sequence.chars.each_index.count do |idx, _|
      @sequence[idx] != test_sequence[idx]
    end
  end
end