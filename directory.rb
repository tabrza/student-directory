$students = []
$cohort = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
$country = []

# cohort = gets.chomp.capitalize
#   if cohort.to_sym != $cohort.each
#     puts "Please enter a correct month. e.g. January"
#   end


def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Filter students by letter"
  puts "4. Filter students by length"
  puts "5. Save student list"
  puts "6. Load students"
  puts "9. Exit"
end

def show_students
  puts print_header
  puts
  puts print_students_list
  puts
  puts print_footer($students)
  puts "-----------------------------------------------------------"
  puts
end

def process(selection)
  case selection
  when "1"
    input_students
  when"2"
    show_students
  when "3"
    puts print_name_starting_with
    puts "-----------------------------------------------------------"
    puts
  when "4"
    puts print_name_short
    puts "-----------------------------------------------------------"
    puts
  when "5"
    puts save_students
    puts "Student list saved"
    puts "-----------------------------------------------------------"
    puts
  when "6"
    puts load_students
    puts "Student list loaded successfully"
    puts "-----------------------------------------------------------"
    puts
  when"9"
    exit
  else
    "Please input a correct command"
  end
end

def input_students
  puts "Hit return twice to finish".center(50)
  puts "-------------------------".center(50)
  puts "Please enter the name (if no name is entered, will move forward to summary)"
  name = STDIN.gets.strip
  # puts "Which cohort do they belong to?"
  # cohort = gets.chomp
  # puts "Country of origin?"
  # country = gets.chomp
  while !name.empty? do
    puts "Which cohort do they belong to?"
    cohort = STDIN.gets.chomp.capitalize.to_sym
    if cohort.empty?
      cohort = Time.new.strftime("%B").to_sym
    else
      until $cohort.include?(cohort)
        puts "Please enter a correct month e.g. January"
        cohort = STDIN.gets.chomp.capitalize.to_sym
      end
    end
    puts "Country of origin?"
    country = STDIN.gets.chomp

    $students << {name: name, cohort: cohort, country: country}
    if $students.count == 1
      puts "There is #{$students.count} student"
    else
      puts "There are now #{$students.count} students"
      puts
    end
      puts
      puts "Please enter another name"
      name = STDIN.gets.chomp
  end
  $students
end

def save_students
  file = File.open("students.csv", "w")
  $students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    $students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
      puts "Loaded #{$students.count} from #{filename}"
    else
      puts "Sorry #{filename} does not exist."
      exit
    end
end

def print_name_starting_with
  if $students.count > 0
    puts "Please type the letter of which students you want to filter out"
    filter = STDIN.gets.chomp.downcase
    puts "The result of filtering by #{filter} is: ".center(50)
    puts $students.select { |student| student[:name].start_with?(filter) }
  end
end

def print_name_short
  if $students.count > 0
    puts "By what length would you like to filter students?"
    size = STDIN.gets.chomp.to_i
    puts "The result of filtering by #{size} is: ".center(50)
    puts $students.select { |student| student[:name].size <= size }
  end
end

def print_by_cohort
  #puts "List by cohort:"
  #month = gets.chomp.capitalize.to_sym
  #puts "The following list is filtered per the month of #{month}:".center(50)
  # puts $cohort.map { |cohort| cohort[:cohort.to_s] == month}

  #   cohorts_list = []
  # $students.map do |student|
  #   cohorts_list << student[:cohort] if !cohorts_list.include?(student[:cohort])
  # end
  # # for each cohort
  # cohorts_list.each do |cohort|
  #   # iterate over students list and print students from that cohort
  #   $students.each_with_index {|student,index| puts "(#{index+1}) #{student[:name]} (#{student[:cohort]} cohort)".center(60) if student[:cohort] == cohort}
  # end
end

def print_header
  puts "The students of this Academy".center(50)
  puts "-----------".center(50)
end

def print_students_list
  # students.each_with_index do |student, index|
  #   puts "(#{index+1}) #{student[:name]} (#{student[:cohort]} cohort)"
  # end
  if $students.count > 0
    list = []
    $students.map do |student|
      list << student[:cohort] if !list.include?(student[:cohort])
    end
    list.each do |cohort|
      $students.each_with_index {|student,index| puts "(#{index+1}) #{student[:name]} (#{student[:cohort]} cohort)".center(60) if student[:cohort] == cohort}
    end
  else
    "There are no students recorded"
  end
end

def print_footer(students)
  if students.count == 1
    puts "Overall, there is #{students.count} student."
  else
    puts "Overall, there are #{students.count} students."
  end
end

puts try_load_students
puts interactive_menu
