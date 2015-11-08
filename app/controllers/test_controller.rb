class TestController < ApplicationController
	def index
	end

	def create
		@test = Test.new(test_params)
		respond_to do |format|
			if @course.save
	      		format.json  { render :json => @test, :status => :created, :location => @test }
			else
	      		format.json  { render :json => @test.errors, :status => :unprocessable_entity }
			end
		end
	end

	def new
		@test = Test.new
	end 

	def edit
	end

	def update 
	end

	def test_params
		params.require(:test).permit(:source_code, :test_case, :owner, :input, :outexpected, :outactual, :passed)
	end 

end
