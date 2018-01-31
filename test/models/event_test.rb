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

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
