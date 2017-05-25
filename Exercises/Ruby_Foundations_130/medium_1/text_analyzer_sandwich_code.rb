class TextAnalyzer
  def process(path)
    File.open(path, 'r') do |file|
      yield(file.read)
    end
  end
end

analyzer = TextAnalyzer.new

analyzer.process('sample_text.txt') do |text|
  puts "#{text.split("\n\n").count} paragraphs"
end
analyzer.process('sample_text.txt') do |text|
  puts "#{text.split("\n").count} lines"
end
analyzer.process('sample_text.txt') do |text|
  puts "#{text.split(' ').count} words"
end

analyzer.process('sample_text_2.txt') do |text|
  puts "#{text.split("\n\n").count} paragraphs"
end
analyzer.process('sample_text_2.txt') do |text|
  puts "#{text.split("\n").count} lines"
end
analyzer.process('sample_text_2.txt') do |text|
  puts "#{text.split(' ').count} words"
end
