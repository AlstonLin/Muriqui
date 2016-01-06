class Problem < ActiveRecord::Base
	self.primary_key = 'id'
	# Relationships
	has_many :test_cases
	belongs_to :assignment
	belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
	belongs_to :remover, :class_name => 'User', :foreign_key => 'remover_id'
	# Validation
	validates :number, presence: true
	validates :creator, presence: true
	validates :source, presence: true

	#------------------INSTANCE METHODS-------------------------------------------
	def initialize(attributes={}, options={})
		template = ['#include <iostream>',
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
    attr_with_defaults = {:source => template}.merge(attributes)
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
				test_string = test_loop.dup
				test_string.gsub! '{{index}}', counter.to_s
				test_string.gsub! '{{input}}', test.input
				test_string.gsub! '{{output}}', test.output
				generated_source += test_string
				counter += 1
			end
		end
		generated_source += after
		return generated_source
	end

	def update_source!
		source = generate_source
		self.update_column(:generated_source, source)
	end

end
