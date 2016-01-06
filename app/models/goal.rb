class Goal < ActiveRecord::Base
  belongs_to :user
  has_one :entry

  def update_goal(params)
    @updated_exercise = get_updated_exercises(params)
    @entry = Goal.find(params[:id]).entry
    record_times
  end

  def record_times
    @updated_exercise.each do |muscle, time|
      original_entry = @entry.send("#{muscle}")
      @entry.send(("#{muscle}="), (original_entry - time.to_i))
    end
    @entry.save
  end

  def get_updated_exercises(params)
    params[:entries].select do |muscle, time|
      muscle if time.present?
    end
  end
end
