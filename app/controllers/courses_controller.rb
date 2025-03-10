class CoursesController < ApplicationController
  before_action :require_login

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  private

  def require_login
    unless session[:student_id]
      redirect_to login_path, alert: "You must be logged in to access this page."
    end
  end
end
def course_params
  params.require(:course).permit(:name, :description, :duration, :instructor, :price)
end
