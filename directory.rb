$students = []
$cohort = []
$country = []

def input_students
  puts "Hit return twice to finish".center(50)
  puts "-------------------------".center(50)
  puts "Please enter the names of the students"
  name = gets.chomp
  puts "Which cohort do they belong to?"
  cohort = gets.chomp
  puts "Country of origin?"
  country = gets.chomp


  until name.empty? do
    $students << {name: name, cohort: cohort, country: country}
    puts "There are now #{$students.count} students"
    name = gets.chomp
    puts "Please enter the name"
    name = gets.chomp
    puts "Which cohort do they belong to?"
    cohort = gets.chomp
    puts "Country of origin?"
    country = gets.chomp
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
puts print(students)
puts print_footer(students)
puts "-----------------------------------------------------------"
puts
puts print_name_starting_with
puts "-----------------------------------------------------------"
puts
puts print_name_short
