class LogsController < ApplicationController

  before_filter :authenticate_user!, :load_most_popular_activities

  autocomplete :activity, :description, :full => true
  
  # GET /logs
  def index
  
    if params[:date] and params[:date].to_date and params[:date].to_date != Time.now.to_date
      @requested_date = params[:date].to_date
      @requested_today = false
    else
      @requested_date = Time.now.to_date
      @requested_today = true
    end

    @logs = Log.
      where(:user_id => current_user.id).
      where("logs.created_at > :day_start and logs.created_at < :day_end", {
        :day_start => @requested_date.at_beginning_of_day, :day_end => @requested_date.tomorrow.at_beginning_of_day
      }).
      includes(:activity)
   
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /logs/new
  def new
    @log = Log.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /logs/1/edit
  def edit
    @log = Log.find(params[:id])
  end

  # POST /logs
  def create
    @log = Log.new(params[:log])
    
    @log.user = current_user

    respond_to do |format|
      if @log.save
        format.html { redirect_to(Log, :notice => 'Log was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /logs/1
  def update
    @log = Log.find(params[:id])

    respond_to do |format|
      if @log.update_attributes(params[:log])
        format.html { redirect_to(Log, :notice => 'Log was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /logs/1
  def destroy
    @log = Log.find(params[:id])
    @log.destroy

    respond_to do |format|
      format.html { redirect_to(logs_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def load_most_popular_activities
  
    @most_popular_activities = Activity.most_popular_activities
  
  end
end
