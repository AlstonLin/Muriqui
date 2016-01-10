class Problem < ActiveRecord::Base
	self.primary_key = 'id'
	# Sorting
	default_scope { order 'number ASC' }
	# Relationships
	has_many :test_cases
	belongs_to :assignment
	belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
	belongs_to :remover, :class_name => 'User', :foreign_key => 'remover_id'
	# Validation
	validates :number, presence: true
	validates :creator, presence: true
	validates :source, presence: true
	validates :instructions, presence: true
	#--------------------------TEMPLATES------------------------------------------
	# TODO: Have course creator make them?
	PYTHON_PRINT_TEMPLATE = ['import sys',
  'import platform',
  'from subprocess import Popen, PIPE, STDOUT',
  'failedCount = 0',
	'def getFileName():',
	'  assert len(sys.argv) == 2, "You must specify exactly one filepath of the executable to test"',
  '  if platform.system() == "Windows":',
  '    return sys.argv[1]',
  '  else:',
  '    return "./" + sys.argv[1]',
	'',
	'def getOutput(filename, inp):',
  '	program = Popen([filename], stdout=PIPE, stdin=PIPE, stderr=STDOUT)',
  '	for line in inp:',
  '		program.stdin.write(line)',
  '	return program.communicate()[0].split("\n")',
	'',
	'def printFail(inp, output, actual):',
  '  print "----------FAILED----------"',
	'  print "Input\n", inp',
	'  print "Expected\n", output',
	'  print "Actual\n", actual',
	'  global failedCount',
	'  failedCount += 1',
	'',
	'def testCase(filename, inp, out):',
	'  actual = getOutput(filename, inp)',
	'  output = out.split("\n")',
  '  inp = inp.split("\n")',
	'  if len(actual) == len(output):',
	'    for i in range(len(actual)):',
	'      if actual[i] != output[i]:',
  '        printFail(inp, output, actual)',
  '        return',
	'  else:',
	'    printFail(inp, output, actual)',
	'',
	'filename = getFileName()',
	'{{each}}',
	'testCase(filename, "{{input}}", "{{output}}")',
	'{{end}}',
	'if failedCount == 0:',
  '	print "Congratulations! All the test cases has passed"',
	'else:',
  '	print "------------------------------"',
  '	print "Failed ", failedCount, " tests. :("'].join("\n") + "\n"

	CPP_FUNCTION_TEMPLATE = ['#include <iostream>',
		'#include <string>',
		'using namespace std;',
		'int FUNCTION_HERE();',
		'int main(){',
		'	string inputs[{{count}}];',
		'	{{each}}',
		'	inputs[{{index}}] = "{{input}}";',
		'	outputs[{{index}}] = "{{output}}";',
		'	assert(INSERT_ASSERT_HERE);',
		'	{{end}}',
		'	cout << "Passed All Test Cases"',
	'}'].join("\n") + "\n"

	MODES = {"Python" => "text/x-python", "C++" => "text/x-c++src"}
	#------------------INSTANCE METHODS-------------------------------------------
	def initialize(attributes={}, options={})
    attr_with_defaults = {:source => PYTHON_PRINT_TEMPLATE}.merge(attributes)
    super(attr_with_defaults)
  end

	def generate_source
		test_cases = self.test_cases
		source = self.source
		generated_source = source.dup
		# Splits the strings from regexes
		error_prefix = "ERROR PARSING SOURCE:"
		# {{count}}
		generated_source.gsub! '{{count}}', self.test_cases.count.to_s
		# {{each}}
		split = generated_source.split(/{{each}}/)
		if split.count != 2
			return error_prefix + "{{each}} must be used exactly once"
		end
		before = split[0]
		after = split[1]
		# {{end}}
		split = after.split(/{{end}}/)
		if split.count != 2
			return error_prefix + "{{end}} must be used exactly once after {{each}}"
		end
		test_loop = split[0]
		after = split[1]
		# Starts building the code
		generated_source = before
		counter = 0
		self.test_cases.each do |test|
			if !test.removed
				input = test.input.dup
				output = test.output.dup
				input.gsub! /\r\n/, '\\n'
				output.gsub! /\r\n/, '\\n'
				test_string = test_loop.dup
				test_string.gsub! '{{index}}', counter.to_s
				test_string.gsub! '{{input}}', input
				test_string.gsub! '{{output}}', output
				generated_source += test_string
				counter += 1
			end
		end
		generated_source += after
		# Subs /r/n with //n for the code
		return generated_source
	end

	def update_source!
		source = generate_source
		self.update_column(:generated_source, source)
	end

end
