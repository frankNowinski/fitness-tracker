class Entry < ActiveRecord::Base
  belongs_to :goal

  def update_entry(params)
    updated_muscles = select_updated_muscles(params)
    entry = Entry.find(params[:id])
    record_updated_times(updated_muscles, entry)
  end

  def record_updated_times(updated_muscles, entry)
    updated_muscles.each do |muscle, updated_time|
      entry.send(("#{muscle}="), (read_attribute(muscle) - updated_time.to_i))
    end
    entry.save
  end

  def select_updated_muscles(params)
    params[:entries].select{|muscle, time| muscle if time.present?}
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
