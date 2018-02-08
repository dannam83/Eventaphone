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

class Event < ApplicationRecord
  validates :name, :date, :time, :address, presence: true
  validates :summary, :details, :organizer, presence: true

  def self.syndicate
    queued_events = Event.where(syndicated: nil)
    queued_events.each do |event|
      event.syndicate
    end
  end

  def syndicate
    if self.summary == "SYNDICATED"
      self.delete
    else
      # add websites below as needed
      self.fill_form("eventbrite.com")
      self.fill_form("eventful.com")
      self.fill_form("localhost:3000")
      self.syndicated = true
      self.save
    end
  end

  def fill_form(url)
    agent = Mechanize.new
    page = agent.get("http://" + url)

    # fields for other websites
    agent.page.forms[0]["name"] = self.name
    agent.page.forms[0]["time"] = self.time
    agent.page.forms[0]["date"] = self.date
    agent.page.forms[0]["address"] = self.address
    agent.page.forms[0]["description"] = self.details

    #form fields for filling out on localhost:3000
    agent.page.forms[0]["event[name]"] = self.name
    agent.page.forms[0]["event[time]"] = self.time
    agent.page.forms[0]["event[date]"] = self.date
    agent.page.forms[0]["event[address]"] = self.address
    agent.page.forms[0]["event[summary]"] = "SYNDICATED"
    agent.page.forms[0]["event[details]"] = self.details
    agent.page.forms[0]["event[organizer]"] = self.organizer
    
    page.forms[0].submit
  end

end
