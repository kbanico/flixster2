class StaticPagesController < ApplicationController
  def index
    if current_user
      redirect_to dashboard_path
    end
  end

  def privacy
  end
end
