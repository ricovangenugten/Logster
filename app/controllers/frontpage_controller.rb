class FrontpageController < ApplicationController

  def index
    @logs = Log.paginate :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @logs }
    end
  end

end
