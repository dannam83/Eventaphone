every 1.minute do
  runner "Event.syndicate", :environment => "development"
end
