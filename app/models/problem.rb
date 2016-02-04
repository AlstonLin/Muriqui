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
	validates :source, presence:
	# Constant
	MODES = {"Python" => "text/x-python", "C++" => "text/x-c++src"}
	#------------------INSTANCE METHODS-------------------------------------------
	def initialize(attributes={}, options={})
    attr_with_defaults = {:source => PYTHON_PRINT_TEMPLATE,
			:instructions => INSTRUCTIONS_TEMPLATE_PYTHON}.merge(attributes)
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

		return generated_source
	end

	def update_source!
		source = generate_source
		self.update_column(:generated_source, source)
	end

end
