class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course
  before_action :require_authorized_for_current_section, only: [:update]

  def new
    #@course = Course.find(params[:course_id])
    @section = Section.new
  end

  def create
    #@course = Course.find(params[:course_id])
    current_course.sections.create(section_params)
    redirect_to instructor_course_path(current_course)
  end

  def update
    current_section.update_attributes(section_params)
    render plain: "updated!"
  end

  helper_method :current_course
  def current_course
    if params[:course_id]
      @current_course ||= Course.find(params[:course_id])
    else
      current_section.course
    end
  end

  private

    def require_authorized_for_current_section
      if current_section.course.user != current_user
        render text: "Unauthorized", status: :unauthorized
      end
    end

    def current_section
      @current_section ||= Section.find(params[:id])
    end

    def section_params
      params.require(:section).permit(:title, :row_order_position)
    end

    def require_authorized_for_current_course
      if current_course.user != current_user
        render text: "Unauthorized", status: :unauthorized
      end
    end
end
