class TemplatesController < ApplicationController
  #-----------------------DEFAULT RESTFUL ACTIONS-------------------------------
  def index
    raise "Not Authorized" unless current_user.admin
    @templates = Template.all
  end

  def new
    raise "Not Authorized" unless current_user.admin
    @template = Template.new
  end

  def edit
    raise "Not Authorized" unless current_user.admin
    @template = Template.find(params[:id])
  end

  def update
    raise "Not Authorized" unless current_user.admin
    @template = Template.find(params[:id])

    respond_to do |format|
      if @template.update_attributes(template_params)
        format.html  {
          flash[:notice] = "Successfully Updated"
          redirect_to templates_path
        }
        format.json
      else
        flash[:alert] = "There was a problem while updating"
        format.html  {
          render :text => "An error occured while saving".html_safe
        }
        format.json
      end
    end
  end

  def create
    raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
		@template = Template.new(template_params)
    @template.creator = current_user
    respond_to do |format|
			if @template.save
				flash[:notice] = "Successfully Created"
				format.html  {
					redirect_to templates_path
				}
    		format.json  {
					 render :json => @template,
					 :status => :created,
					 :location => @template
				 }
    		format.js
			end
		end
  end
  #---------------------OTHER RESTFUL ACTIONS-----------------------------------
  def remove
    raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
    @template = Template.find(params[:template_id])
    @templates = Template.all
    remove_object @template
  end

  def fill_form
    raise "Unauthorized Access! You must be an admin to do this." unless current_user.admin
    @template = Template.find(params[:template_id])
    respond_to do |format|
      format.js
    end
  end
  #---------------------EXTERNALIZED FUNCTIONS----------------------------------
	def template_params
      params.require(:template).permit(:name, :instructions, :code, :mode)
  end
end
