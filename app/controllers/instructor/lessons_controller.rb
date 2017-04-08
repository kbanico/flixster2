class Instructor::LessonsController < ApplicationController
  def new
    # this helps us pass in the section to the form in the url
    @section = Section.find(params[:section_id])
    @lesson = Lesson.new
  end

  def create
    # we find the section to use it to create a lesson @section.lessons.create
    @section = Section.find(params[:section_id])
    @lesson = @section.lessons.create(lesson_params)
    redirect_to instructor_course_path(@section.course)
  end

  private
  def lesson_params
    params.require(:lesson).permit(:title, :subtitle)
  end

end
