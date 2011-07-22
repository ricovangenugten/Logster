class FrontpageController < ApplicationController

  before_filter :load_most_popular_activities

  def index
  
    if params[:date] and params[:date].to_date and params[:date].to_date != Time.now.to_date
      @requested_date = params[:date].to_date
      @requested_today = false
    else
      @requested_date = Time.now.to_date
      @requested_today = true
    end

    @logs = Log.
      where("logs.created_at > :day_start and logs.created_at < :day_end", {
        :day_start => @requested_date.at_beginning_of_day, :day_end => @requested_date.tomorrow.at_beginning_of_day
      }).
      includes(:activity, :user)
      
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @logs }
    end
  end
  
  private
  def load_most_popular_activities
  
    @most_popular_activities = Activity.most_popular_activities
  
  end

end
