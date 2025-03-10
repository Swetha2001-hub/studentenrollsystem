class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      session[:student_id] = @student.id
      redirect_to courses_path, notice: "Signed up successfully!"
    else
      render :new
    end
  end

  def login
  end

  def authenticate
    student = Student.find_by(email: params[:email])
  
    if student.nil?
      flash.now[:alert] = "Email not found."
      render :login, status: :unprocessable_entity
    elsif !student.authenticate(params[:password])
      flash.now[:alert] = "Incorrect password. Please try again."
      render :login, status: :unprocessable_entity
    else
      session[:student_id] = student.id
      redirect_to dashboard_path, notice: "Logged in successfully!"
    end
  end
  
  def logout
    session[:student_id] = nil
    redirect_to login_path, notice: "Logged out successfully!"
  end
  def dashboard
    @student = Student.find(session[:student_id])
    @enrolled_courses = @student.courses
  end


  before_action :require_login, only: [:dashboard]
  def enrolled_courses
    @student = Student.find(session[:student_id])  # Get the logged-in student
    @enrolled_courses = @student.courses           # Fetch only the courses they are enrolled in
  end

private

def require_login
  unless session[:student_id]
    redirect_to login_path, alert: "You must be logged in to access this page."
  end
end

  private

  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation)
  end
end
