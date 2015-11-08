class SourceCodesController < ApplicationController
	respond_to :html, :js
	skip_before_filter :verify_authenticity_token 
	
	def show
		@source_code = SourceCode.find(params[:id])
		@contents = @source_code.attachment.read #This is where the actual code is stored
	end 

	def create
		@source_code = SourceCode.new(source_params)
		@source_code.passed = 0
		@source_code.total = 0
		respond_to do |format|
			if @source_code.save
				format.html  { 
					redirect_to @source_code,	
					alert:'Uploaded'
				}
	      		format.json  { render :json => @source_code, :status => :created, :location => @source_code }
	      		execute_code(@source_code)
			else
				format.html  {
					render :action => "new"
				}
	      		format.json  { render :json => @source_code.errors, :status => :unprocessable_entity }
			end
		end
	end
	
	def new 
		@source_code = SourceCode.new
	end

	def destroy
	end

	def source_params
      params.require(:source_code).permit(:name, :attachment, :owner_id, :problem_id)
  	end

  	def execute_code(source_code)
  		for test_case in @source_code.problem.test_cases	
  			#TODO: ADD THE C COMPILATION HERE AND CREATE NEW TEST CASES
  			actualoutput = "out"
  			#Above is a dummy actualoutput
  			passed = actualoutput == test_case.output #TODO: MAKE THIS WORK FOR INTEGER / FLOAT INPUT & OUTPUT AS WELL
  			test = Test.new(source_code: @source_code, test_case: test_case, owner: @source_code.owner, input: test_case.input, outexpected: test_case.output, outactual: actualoutput, passed: passed)
  			@source_code.passed += 1 if passed
  			@source_code.total += 1
  			@source_code.tests << test
  		end 
  		@source_code.save
  	end
  	
end
