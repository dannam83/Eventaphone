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

  def self.test
    event = Event.first
    if event.syndicated
      event.syndicated = false
      event.save
    else
      event.syndicated = true
      event.save
    end
  end

  def self.syndicate
    queued_events = Event.where(syndicated: nil)
    queued_events.each do |event|

    end
  end

  def syndicate
    self.fill_form("eventbrite")
    self.fill_form("timeout")
    self.fill_form("nyc")
    self.fill_form("events12")
    self.fill_form("thrillist")
    self.syndicated = true
  end

  def fill_form(website)
  end

end
