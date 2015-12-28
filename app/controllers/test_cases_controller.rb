class TestCasesController < ApplicationController
	before_filter :load_problem

	def index
		@problem = Problem.find(params[:problem_id])
		@assignment = @problem.assignment
		@course = @assignment.course
		@test_case = TestCase.new
	end

	def create
		@test_case = TestCase.new(test_case_params)
		@test_case.problem = @problem
		@test_case.creator = current_user

		respond_to do |format|
			if @test_case.save
				format.html  {
					redirect_to @test_case,
					alert:'Test Case was successfully created.'
				}
	      format.json  { render :json => @test_case, :status => :created, :location => @test_case }
				format.js
			else
				format.html  {
					render :text => "ERROR".html_safe
				}
	      format.json  { render :json => @test_case.errors, :status => :unprocessable_entity }
			end
		end
	end

	def update
		test_case = TestCase.find(params[:test_case_id])
		raise "Unauthorized Access! You must be an admin to do this." unless
			current_user.admin || current_user == test_case.creator
		#TODO: Make entries editable
	end

	def test_case_params
      params.require(:test_case).permit(:input, :output)
	end

	def load_problem
		if (params[:problem_id])
			@problem = Problem.find(params[:problem_id])
		else
			@problem = TestCase.find(params[:test_case_id]).problem
		end
	end

	def toggle_flag
		raise "Must be logged in to flag a test case!" unless current_user
		test_case = TestCase.find(params[:test_case_id])

		if test_case.flaggers.include?(current_user)
			test_case.flaggers.delete(current_user)
		else
			test_case.flaggers << current_user
		end
		respond_to do |format|
			if test_case.save
				format.html  {
					render :text => 'This page should not be shown.'.html_safe
				}
				format.json
				format.js
			else
				format.html  {
					render :text => "There was an error while creating the Test Case".html_safe
				}
				format.json
			end
		end
	end

	helper_method :toggle_flag

	def toggle_remove
		raise "Must be logged in to flag a test case!" unless current_user
		test_case = TestCase.find(params[:test_case_id])

		if test_case.removed
			test_case.remover = nil
			test_case.removed = false
		else
			test_case.remover = current_user
			test_case.removed = true
		end
		respond_to do |format|
			if test_case.save
				format.html  {
					render :text => 'This page should not be shown.'.html_safe
				}
				format.json  { render :json => test_case, :status => :created, :location => test_case }
				format.js
			else
				format.html  {
					render :text => "There was an error while removing the Test Case".html_safe
				}
				format.json  { render :json => test_case.errors, :status => :unprocessable_entity }
			end
		end
	end
	helper_method :toggle_remove

end
