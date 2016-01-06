class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?

	#----------------GLOBAL HELPER METHODS----------------------------------------
	#-------------------------------RESTFUL ACTIONS-------------------------------
	def privacy
	end
	#----------------COMMONLY USED ACTIONS FOR CONTROLLERS------------------------
	def remove_object(object)
		object.removed = true
		object.remover = current_user
		respond_to do |format|
			if object.save
				flash[:notice] = "Successfully Removed"
				format.html  {
					render :text => 'This page should not be shown.'.html_safe
				}
				format.json  { render :json => object, :status => :notice, :location => object }
				format.js
			else
				flash[:alert] = "There was a problem while removing"
				format.html  {
					render :text => "There was an error while removing".html_safe
				}
				format.json  { render :json => object.errors, :status => :unprocessable_entity }
			end
		end
	end


	def save_created_object(object)
		respond_to do |format|
			if object.save
				flash[:notice] = "Successfully Created"
				format.html  {
					redirect_to object
				}
    		format.json  {
					 render :json => object,
					 :status => :created,
					 :location => object
				 }
    		format.js
			end
		end
	end


	def save_object(object)
		respond_to do |format|
			if object.save
				format.html  {
					flash[:notice] = "Successfully Updated"
					redirect_to object
				}
				format.json
				format.js
			else
				flash[:alert] = "There was a problem while updating"
				format.html  {
					render :text => "An error occured while saving".html_safe
				}
				format.json
				format.js
			end
		end
	end
	#-----------------------------------------OTHER-------------------------------
	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) << :name
	end

	def after_sign_in_path_for(user)
		courses_path
	end

	def after_sign_out_path_for(user)
		courses_path
	end
end
