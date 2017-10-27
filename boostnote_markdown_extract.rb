require 'pry'
def form_title(title)
  title.gsub!(/\Atitle: /, '')
  title.tr!(' ', '_')
  title.tr!('"', '')
  title = title.gsub('/', '_')
  title = title.gsub("\r", '')
  title = title.gsub('\\', '')
  title = title.gsub('.', '')
  title = title.gsub('?', '')
  title = title.gsub(',', '')
  title = title.gsub('-', '_')
  title = title.gsub(/_+/, '_')
end

def get_data(lines)
  title = ''
  content = []

  take = false
  lines.each do |line|
    # if content is over and tags start, then break
    break if line.match?(/\Atags:/)

    # if title tag is found, add title to hash
    if line.match?(/\Atitle: /)
      title = form_title(line)
    end

    # if in content area, add line to content
    if take && !line.match?("'")
      # cut off first 2 spaces
      content.push(line[2..-1])
    end

    # if content marker is found, start taking the next lines
    take = true if line.match?(/\Acontent:/)
  end
  content = content.join("\n")

  { title: title, content: content }
end

# Get all boostnote cson file paths
files = Dir.glob('./Notes/Boostnote/notes/*.cson').map do |filename|
  File.expand_path(filename)
end

files.each_with_index do |filename, index|
  file = File.read(filename)
  lines = file.split("\n")

  content = get_data(lines)

  File.open("./boostnote_markdowns/#{content[:title]}_#{index}.md", 'w') do |f|
    f.write(content[:content])
  end
end
