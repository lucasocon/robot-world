class Chassis < ActiveRecord::Base
  belongs_to :car

  TYPES = [
    'Ladder',
    'Backbone',
    'Monocoque',
    'Space',
    'Combination'
  ]
end
