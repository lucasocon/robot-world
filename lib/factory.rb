module Factory
  class CarNotFound < StandardError; end

  class Car

    MODELS = [
      'Ferrari',
      'Bugatti',
      'Chevrolet',
      'Kia',
      'Renault',
      'BMW',
      'Peugeot',
      'Toyota',
      'Maserati',
      'Alfa Romeo'
    ].freeze

    YEARS = [*2010..2020]

    FAILURES = [
      'wheels_failure',
      'chassis_failure',
      'laser_failure',
      'computer_failure',
      'engine_failure',
      'seats_failure'
    ]

    attr_accessor :car_model, :year, :price, :cost_price

    def self.create
      car = Car.new
      car.car_model = MODELS.sample
      car.year = YEARS.sample
      car.price = rand(50000000..100000000)
      car.cost_price = rand(30000000..80000000)
      car
    end

    def self.generate_code
      (0...5).map { ('a'..'z').to_a[rand(26)] }.join
    end
  end
end
