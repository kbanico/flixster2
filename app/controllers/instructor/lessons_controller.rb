class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section
  def new
    # this helps us pass in the section to the form in the url
    #@section = Section.find(params[:section_id])
    # lock down new action
    # if current_section.course.user != current_user
    #   return render text: "Unauthorized", status: :unauthorized
    # end
    @lesson = Lesson.new
  end

  def create
    # we find the section to use it to create a lesson @section.lessons.create
    #@section = Section.find(params[:section_id])
    # lock down create action
    # if current_section.course.user != current_user
    #   return render text: "Unauthorized", status: :unauthorized
    # end
    @lesson = current_section.lessons.create(lesson_params)
    redirect_to instructor_course_path(current_section.course)
  end

  private

  helper_method :current_section

  def require_authorized_for_current_section
    if current_section.course.user != current_user
      return render text: "Unauthroized", status: :unauthorized
    end
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video)
  end

  def current_section
    @current_section ||= Section.find(params[:section_id])
  end

end
