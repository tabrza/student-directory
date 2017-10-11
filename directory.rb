def input_students
  puts "Please enter the names of the students"
  puts "Hit return twice to finish"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "There are now #{students.count} students"
    name = gets.chomp
  end
  students
end


def print_header
  puts "The students of this Academy"
  puts "-----------"
end

def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(students)
  puts "Overall, there are #{students.count} great students."
end

students = input_students
puts print_header
puts print(students)
puts print_footer(students)

# Total number of students now printed
