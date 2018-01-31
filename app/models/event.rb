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

# require 'mechanize'

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
      event.syndicate
    end
  end

  def syndicate
    self.fill_form("eventbrite.com")
    self.fill_form("lanyrd.com")
    self.fill_form("yelp.com")
    self.fill_form("eventful.com")
    self.fill_form("eventsetter.com")
    self.syndicated = true
    self.save
  end

  def fill_form(url)
    agent = Mechanize.new
    page = agent.get("http://" + url)
    agent.page.forms[0]["name"] = self.name
    agent.page.forms[0]["title"] = self.name
    agent.page.forms[0]["Time"] = self.time
    agent.page.forms[0]["date"] = self.date
    agent.page.forms[0]["address"] = self.address
    agent.page.forms[0]["location"] = self.address
    agent.page.forms[0]["summary"] = self.summary
    agent.page.forms[0]["details"] = self.details
    agent.page.forms[0]["description"] = self.details
    agent.page.forms[0]["organizer"] = self.organizer
    agent.page.forms[0]["event[name]"] = self.name
    agent.page.forms[0]["event[time]"] = self.time
    agent.page.forms[0]["event[date]"] = self.date
    agent.page.forms[0]["event[address]"] = self.address
    agent.page.forms[0]["event[summary]"] = self.summary
    agent.page.forms[0]["event[details]"] = self.details
    agent.page.forms[0]["event[organizer]"] = self.organizer
    page.forms[0].submit
  end

end
