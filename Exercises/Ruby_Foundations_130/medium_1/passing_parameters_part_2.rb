def assign(array)
  yield(array)
end

assign(%w(raven finch hawk eagle)) do |_, _, *raptors|
  puts "Raptors: #{raptors.join(', ')}."
end