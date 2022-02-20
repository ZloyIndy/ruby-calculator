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

def calculate(problem)
	problem = problem.split(/(\d+\.?\d*)/).reject(&:empty?)
	if validationAll(problem)
		j = 1
		operationsOrder = [
		['^'],
		['/','*'],
		['+','-']
		]
		operationsOrder.each_with_index{ |val,index|
			val.each{ |v|
				while problem.index(v)
					#puts "#{v} is in #{problem} = #{problem.index(v)}"
					puts "#{j})#{problem.join('')} = "
					tempIndex = problem.index(v)
					a = Float(problem[tempIndex-1],exception: false)
					b = Float(problem[tempIndex+1],exception: false)
					o = problem[tempIndex]
					
					problem.delete_at(tempIndex-1)
					problem.delete_at(tempIndex-1)
					problem.delete_at(tempIndex-1)
					
					problem.insert(tempIndex-1,compute(a,b,o).to_s)
					j += 1
				end
			}
		}
		result = problem[-1]
		return result
	else
		puts $errors
		return false
	end
end

def underline 
	puts "______________________"
end

def validationAll (problem)
	problem.each_cons(3) { |a,o,b|
		a = Float(a,exception: false)
		b = Float(b,exception: false)
		if a.is_a?(Numeric) == false 
		$errors << "Found not numeric character #{a} where numeric was expected"
		end
		if $operations.include?(o) == false
			$errors << "Found exceptional operation #{o} where operation was expected. List of available operations: #{$operations}"
		end
		if b.is_a?(Numeric) == false
			$errors << "Found not numeric character #{b} where numeric was expected"
		end
		if o == '/' && b == 0
			$errors << "You can't divide by 0 :("
		end
		if $errors.length > 0
			$errors.unshift "\r\n__//List of errors//__"
			$errors << 		"______________________"
		end
		return true
	}
end

def startMessage
	$errors.clear
	puts 'psst wanna calculate some? [y/n]'
	
	getStart = gets.chomp.downcase
	startAcceptable = ['y','','н']
	if startAcceptable.include?(getStart)
		puts "Please type in math problem using listed operations #{$operations} (like 2+2*3^2/1-9)"
		puts "Brackets are not yet supported"
		underline
		getProblem = gets.chomp
		problem = getProblem.gsub(' ', '')
		#/(\d+\.?\d*)/
		
		result = calculate(problem)
		if result == false 
			puts $errors
			startMessage
		else
			#puts "\r\n#{getProblem} = #{result}"
			puts "= #{result}"
			underline
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

	