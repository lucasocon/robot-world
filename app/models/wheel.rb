class Wheel < ActiveRecord::Base
  belongs_to :car

  BRANDS = [
    'Goodyear',
    'Yokohama',
    'Dunlop',
    'Firestone',
    'Kumho',
    'Continental',
    'Hankook',
    'Toyo',
    'Michelin',
    'Pirelli',
    'Bridgestone',
  ]
end
