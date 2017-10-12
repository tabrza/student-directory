$students = []
$cohort = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
$country = []

# cohort = gets.chomp.capitalize
#   if cohort.to_sym != $cohort.each
#     puts "Please enter a correct month. e.g. January"
#   end


def input_students
  puts "Hit return twice to finish".center(50)
  puts "-------------------------".center(50)
  puts "Please enter the name"
  name = gets.chomp
  # puts "Which cohort do they belong to?"
  # cohort = gets.chomp
  # puts "Country of origin?"
  # country = gets.chomp
  while !name.empty? do
    puts "Which cohort do they belong to?"
    cohort = gets.chomp.capitalize.to_sym
    if cohort.empty?
      cohort = Time.new.strftime("%B").to_sym
    else
      until $cohort.include?(cohort)
        puts "Please enter a correct month e.g. January"
        cohort = gets.chomp.capitalize.to_sym
    end
  end
    puts "Country of origin?"
    country = gets.chomp

    $students << {name: name, cohort: cohort, country: country}
      puts "There are now #{$students.count} students"
      puts
      puts "Please enter another name"
      name = gets.chomp
  end
  $students
end


def print_name_starting_with
  puts "Please type the letter of which students you want to filter out"
  filter = gets.chomp.downcase
  puts "The result of filtering by #{filter} is: ".center(50)
  puts $students.select { |student| student[:name].start_with?(filter) }
end

def print_name_short
  puts "By what length would you like to filter students?"
  size = gets.chomp.to_i
  puts "The result of filtering by #{size} is: ".center(50)
  puts $students.select { |student| student[:name].size <= size }
end

def print_header
  puts "The students of this Academy".center(50)
  puts "-----------".center(50)
end

def print(students)
  students.each_with_index do |student, index|
    puts "(#{index+1}) #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(students)
  puts "Overall, there are #{students.count} great students."
end


students = input_students
puts print_header
puts
puts print(students)
puts
puts print_footer(students)
puts "-----------------------------------------------------------"
puts
puts print_name_starting_with
puts "-----------------------------------------------------------"
puts
puts print_name_short
