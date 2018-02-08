# Eventaphone

## Introduction
Eventaphone is built entirely on the Ruby On Rails platform. It is designed to take event information and then automatically do periodic checks to see if there are any newly submitted events to send out to other websites. If there are, it will automatically go to those other websites, fill out their form, and submit it. Eventaphone demonstrates the ability of Ruby On Rails to generate HTML, create forms, interact with websites on its own, and also interact with the user all from the backend.

## Setup
1. Download the folder
2. Use your terminal to navigate to the folder and then...
```
$ bundle install
$ wheneverize
$ rails s
```
3. Navigate on your browser to: localhost:3000/.

## Usage
Start by entering information for your event. You'll need to fill out the whole form for it to submit properly. 

Upon submission you'll see your event show up under Queued Events. 

Eventaphone is set to check every minute to see if there are any new events in the queue, and if there are, it will syndicate those events to the other websites and mark that your event has been syndicated. If you refresh the page after a minute, it will show that your event was syndicated.

We don't want the list of syndicated events to grow infinitely long, so after a minute of indicating that the event was syndicated, it will remove the event from the list. Try refreshing the page a minute after your event is syndicated. You'll see that your event is no longer listed under Queued Events.

## Technical
### HTML + Ruby
Ruby On rails has the ability to combine HTML with Ruby methods. By using the filename extension .html.erb we get these capabilities. Furthermore, with ActiveRecord at our disposal, we can also directly interact with our database at the same time as is done below.
```erb
<% @queued_events = Event.where(syndicated: nil) %>

  <ul class="queuedEvents">
    <% if @queued_events.length == 0 %>
      <li>
        No events to syndicate
      </li>
    <% else %>
      <% @queued_events.each do |event| %>
        <li>
          <%= event.name %>: <%= event.summary %>
        </li>
      <% end %>
    <% end %>
  </ul>
```
### Wheneverize Gem
Wheneverize is a gem that provides the functionality of creating automated periodic events. You can set something to happen after so many minutes, hours, or days, and you can also set it to run on certain days and/or at certain times. For the sake of demonstration, I have set the syndicating process to run every minute. 

Wheneverize creates a schedule.rb file in the config folder. Schedule.rb is where you can put commands for wheneverize. 
```ruby
every 1.minute do
  runner "Event.syndicate", :environment => "development"
end
```
Once you have your scheduled events entered, to update the list of automated processes on the server, run the command
```
$ wheneverize --update-crontab
```
Now we've got automated syndication!
### Mechanize Gem
Mechanize allows you to create methods that interact with webpages. You can navigate to a page, fill in inputs, submit forms, and click over to other links as well. For our purposes, we simply need to navigate to a page, find the input fields, fill in those input fields with the appropriate information, and click submit.
```ruby
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
```
### Functionality
The app currently does not actually enter information on any other websites. To make it fully work, the server must first be logged into the websites where information is being entered. If the server is logged in, we only need to specify the exact url and identify the fields that need information in the fill_form(url) method above.

Thanks for checking out Eventaphone!

