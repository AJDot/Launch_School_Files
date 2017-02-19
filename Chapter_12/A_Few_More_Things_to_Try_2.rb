=begin
  Birthday helper!

  Write a program to read in names and birth dates from a text file.
  It should then ask you for a name. You type one in, and it tells
  you when that person's next birthday will be (and, for the truly
  adventurous, how old they will be). The input file should look something
  like this:

    Christopher Alexander,  Oct  4, 1936
    Christopher Lambert,    Mar 29, 1957
=end


def get_birthday name
  months = {'January' => 1,
            'February' => 2,
            'March' => 3,
            'April' => 4,
            'May' => 5,
            'June' => 6,
            'July' => 7,
            'August' => 8,
            'September' => 9,
            'October' => 10,
            'November' => 11,
            'December' => 12}

  # Windows file location
  filename = 'E:\Users\Alex\Programming-Local\GitHub Repositories\AJDot\Learn_to_Program_The_Facets_of_Ruby\Chapter_12\bday_list.txt'
  bday_hash = Hash.new

  # Make name:bday hash
  name_bday_list = File.read(filename).each_line do |entry|
    entry = entry.chomp
    index = 0
    while index < entry.length
      if entry[index] == ','
        bday_hash[entry[0..index - 1]] = entry[index + 2 .. -1]
        break
      end
      index += 1
    end
  end

  now = Time.new
  # get month/day and year
  month_day, year = bday_hash[name].split(',')
  # cut off the first space
  bday_year = year[1..-1]
  # get month and day
  bday_month, bday_day = month_day.split(" ")

  # calc age
  age = now.year - bday_year.to_i

  if !bday_hash[name]
    return puts "That name does not exist on the list!"
  else
    # adjust age if birthday already passed this year
    if now.month > months[bday_month] || (now.month == months[bday_month] && now.day > bday_day.to_i)
      age += 1
    end

    # display birthday
    if now.month == months[bday_month] && now.day == bday_day.to_i
      puts "#{name} turns #{age} TODAY!!"
    else
      puts "#{name} turns #{age} on #{month_day}."
    end
  end
end

puts 'Enter a name:'
name = gets.chomp
get_birthday name
