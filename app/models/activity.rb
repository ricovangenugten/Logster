class Activity < ActiveRecord::Base
  has_many :logs
  
  def self.most_popular_activities
        
    most_popular_activities = []
    
    Activity.joins(:logs).group(:activity_id).count().sort.take(5).each do |activity_counts|
    
      most_popular_activities << {:id => activity_counts.first, :count => activity_counts.second, :description => Activity.find(activity_counts.first).description}
     
    end
    
    most_popular_activities    
 
  end
  
end
