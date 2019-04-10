class Seat < ActiveRecord::Base
  belongs_to :car

  TYPES = [
    'Racing',
    'Sport & Tuner',
    'Suspension',
    'Classic'
  ]
end
