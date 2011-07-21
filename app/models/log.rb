class Log < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user
    
  default_scope :order => 'created_at desc'
  
  def activity_description=description
    @activity = Activity.find_or_create_by_description(description)
    self.activity = @activity
  end
  
  def activity_description
    if self.activity
      self.activity.description
    end
  end
  
end
