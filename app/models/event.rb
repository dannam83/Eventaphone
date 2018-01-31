# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  date       :text             not null
#  time       :text             not null
#  address    :text             not null
#  summary    :text             not null
#  details    :text             not null
#  organizer  :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  syndicated :boolean
#

class Event < ApplicationRecord
  validates :name, :date, :time, :address, presence: true
  validates :summary, :details, :organizer, presence: true
end
