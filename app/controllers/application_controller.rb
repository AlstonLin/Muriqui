class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	#----------------GLOBAL HELPER METHODS----------------------------------------
	def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

	#-------------------------------RESTFUL ACTIONS-------------------------------
	def privacy
	end
	#----------------COMMONLY USED ACTIONS FOR CONTROLLERS------------------------
	def remove_object(object)
		object.removed = true
		object.remover = current_user
		respond_to do |format|
			if object.save
				flash[:success] = "Successfully Removed"
				format.html  {
					render :text => 'This page should not be shown.'.html_safe
				}
				format.json  { render :json => object, :status => :success, :location => object }
				format.js
			else
				flash[:danger] = "There was a problem while removing"
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
				flash[:success] = "Successfully Created"
				format.html  {
					redirect_to object
				}
    		format.json  {
					 render :json => object,
					 :status => :created,
					 :location => object
				 }
    		format.js
			else
				flash[:danger] = "There was a problem while creating"
				format.html  {
					render :action => "new"
				}
    		format.json  {
					render :json => object.errors,
					:status => :unprocessable_entity
				}
			end
		end
	end


	def save_object(object)
		respond_to do |format|
			if object.save
				format.html  {
					flash[:success] = "Successfully Updated"
					redirect_to object
				}
				format.json
				format.js
			else
				flash[:danger] = "There was a problem while updating"
				format.html  {
					render :text => "An error occured while saving".html_safe
				}
				format.json
				format.js
			end
		end
	end

end
