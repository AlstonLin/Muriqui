class SourceCodesController < ApplicationController
	respond_to :html, :js
	skip_before_filter :verify_authenticity_token 
	
	def show
		@source_code = SourceCode.find(params[:id])
		@contents = @source_code.attachment.read #This is where the actual code is stored
	end 

	def create
		@source_code = SourceCode.new(source_params)
		respond_to do |format|
			if @source_code.save
				format.html  { 
					redirect_to @source_code,	
					alert:'Problem was successfully created.'
				}
	      		format.json  { render :json => @source_code, :status => :created, :location => @source_code }
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
end
