every 1.hour do
  runner "Event.syndicate", :environment => "development"
end
