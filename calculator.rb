def compute(a,b,o)
	case o
		when '^'
			r = a**b
		when '*'
			r = a*b
		when '/'
			r = a/b
		when '+'
			r = a+b
		when '-'
			r = a-b		
	end
	return r 	
end

$errors = []
$operations = ['*','/','+','-','^']

def validation(a,b,o)
	validated = true
	
	if a.is_a?(Numeric) == false 
		$errors << "Firsh character must be numeric"
	end
	if $operations.include?(o) == false
		$errors << "Second character must be one of the following operations: #{$operations}"
	end
	if b.is_a?(Numeric) == false
		$errors << "Third character must be numeric"
	end
	if o == '/' && b == 0
		$errors << "You can't divide by 0 :(\r\n"
	end
	if $errors.length > 0
		validated = false
		$errors.unshift "\r\n__//List of errors//__"
		$errors << 		"______________________"
	end
	return validated
end

def startMessage
	$errors.clear
	puts 'psst want some calculations? [y/n]'
	#puts '[y/n] (empty string counts as Yes)'
	getStart = gets.chomp.downcase
	
	if getStart == 'y' || getStart == ''
		puts "Please type in math problem with [2] numbers using one of the operations #{$operations} (like 2+2)"
		getProblem = gets.chomp
		
		#/(\d+\.?\d*)/
		problem = getProblem.gsub(' ', '').split(/(\d+\.?\d*)/).reject(&:empty?)
		if problem.length != 3
			$errors << "The problem must contain 3 characters (like 2+2)"
		end
		a = Float(problem[0],exception: false)
		b = Float(problem[2],exception: false)
		o = problem[1]
		if validation(a,b,o) 
			puts "\r\n#{getProblem} = #{compute(a,b,o)}"
			puts ''
			startMessage
		else 
			puts $errors
			startMessage
		end
	elsif getStart == 'n'
		puts 'Bye!'
	else 
		puts "Sadly I'm not smart enough to understand your command :("
		startMessage
	end
end

puts "Hello! I'm Calculator"
startMessage

	