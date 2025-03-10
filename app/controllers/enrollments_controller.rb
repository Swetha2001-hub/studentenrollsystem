class EnrollmentsController < ApplicationController
  before_action :require_login

  def create
    Rails.logger.debug "📌 Params received: #{params.inspect}" # Debugging step
  
    course = Course.find_by(id: params[:course_id])  # ✅ Use `find_by` to prevent crashes
  
    if course.nil?
      redirect_to courses_path, alert: "Error: Course not found."
      return
    end
  
    if Enrollment.exists?(student_id: session[:student_id], course_id: course.id)
      redirect_to courses_path, alert: "You are already enrolled in this course."
    else
      Enrollment.create(student_id: session[:student_id], course_id: course.id)
      redirect_to enrolled_courses_path, notice: "Successfully enrolled in #{course.name}!"
    end
  end
  

  def destroy
    enrollment = Enrollment.find(params[:id])  # ✅ Find by `id`, NOT `course_id`
  
    if enrollment
      enrollment.destroy
      redirect_to enrolled_courses_path, notice: "Unenrolled from the course."
    else
      redirect_to enrolled_courses_path, alert: "Error: Enrollment not found."
    end
  end
  
  private

  def require_login
    unless session[:student_id]
      redirect_to login_path, alert: "You must be logged in to access this page."
    end
  end
end
