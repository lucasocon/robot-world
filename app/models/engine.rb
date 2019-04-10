class Engine < ActiveRecord::Base
  belongs_to :car

  TYPES = [
    'VEE',
    'INLINE',
    'STRAIGHT',
    'VR and W',
    'BOXER',
    'ROTARY'
  ]
end
