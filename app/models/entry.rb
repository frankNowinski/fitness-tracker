class Entry < ActiveRecord::Base
  belongs_to :goal

  def update_entry(params)
    updated_exercises = get_updated_exercises(params)
    entry = Entry.find(params[:id])
    record_updated_times(updated_exercises, entry)
  end

  def record_updated_times(updated_exercises, entry)
    updated_exercises.each do |muscle, updated_time|
      original_time = entry.send("#{muscle}")
      entry.send(("#{muscle}="), (original_time - updated_time.to_i))
    end
    entry.save
  end

  def get_updated_exercises(params)
    params[:entries].select do |muscle, time|
      muscle if time.present?
    end
  end

  def days_left
    7 - (Time.now.day - self.day) % 31
  end

  def day
    "#{self.created_at.day}".to_i
  end

  def date_created
    "#{self.created_at.month}/#{self.created_at.day}/#{self.created_at.year}"
  end
end
