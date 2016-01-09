class Goal < ActiveRecord::Base
  belongs_to :user
  has_one :entry

  def self.valid_params?(params)
    params[:title].present? && supplied_entries?(params)
  end

  def self.supplied_entries?(params)
    params[:entries].values.any?{|entry| entry != ""}
  end

  # def self.numeric_values(params)
  #   params[:entries].values.each do |time|
  #     binding.pry
  #   end
  # end

end
