$students = []

def input_students
  puts "Please enter the names of the students"
  puts "Hit return twice to finish"
  name = gets.chomp
  while !name.empty? do
    $students << {name: name, cohort: :november}
    puts "There are now #{$students.count} students"
    name = gets.chomp
  end
  $students
end


def print_name_starting_with
  puts "Please type the letter of which students you want to filter out"
  filter = gets.chomp
  puts $students.select { |student| student[:name].start_with?(filter) }
end

def print_name_short
  puts "Printing students with names under 12 characters"
  puts "..........."
  puts $students.select { |student| student[:name].size <13 }
end

def print_header
  puts "The students of this Academy"
  puts "-----------"
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
puts print_name_starting_with
puts print_name_short
