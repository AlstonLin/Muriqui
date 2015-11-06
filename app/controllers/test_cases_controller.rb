class TestCasesController < ApplicationController
	before_filter :load_problem

	def index
		@test_case = @problem.find(params[:id])
	end

	def create
		@test_case = @problem.test_cases.build(test_case_params)
		@test_case.problem = @problem
		@test_case.legal = true
		@test_case.creator = current_user
		respond_to do |format|
			if @test_case.save
				format.html  { 
					redirect_to @test_case,	
					alert:'Assignment was successfully created.'
				}
	      		format.json  { render :json => @test_case, :status => :created, :location => @test_case }
			else
				format.html  {
					render :action => "new"
				}
	      		format.json  { render :json => @test_case.errors, :status => :unprocessable_entity }
			end
		end
	end

	def new
		@test_case = @problem.test_cases.build
	end

	def edit
	end

	def show
		@test_case = @problem.test_cases.find(params[:id])
	end

	def update
	end 

	def destroy
	end

	def test_case_params
      params.require(:test_case).permit(:input, :output)
  	end
  	
  	def load_problem
  		if (params[:problem_id])
  			@problem = Problem.find(params[:problem_id])
  		else
  			@problem = TestCase.find(params[:id]).problem
  		end
  	end
end
