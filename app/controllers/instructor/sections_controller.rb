class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course
  def new
    #@course = Course.find(params[:course_id])
    @section = Section.new
  end

  def create
    #@course = Course.find(params[:course_id])
    @section = @course.sections.create(section_params)
    redirect_to instructor_course_path(@course)
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:course_id])
  end

  private
    def section_params
      params.require(:section).permit(:title)
    end

    def require_authorized_for_current_course
      if current_course.user != current_user
        render text: "Unauthorized", status: :unauthorized
      end
    end
end