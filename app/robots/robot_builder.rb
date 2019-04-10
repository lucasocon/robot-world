require 'factory'

class RobotBuilder < ActiveJob::Base
  queue_as :default

  def perform(*args)
    factory = Factory::Car.create

    car = Car.create(
      price: factory.price,
      cost_price: factory.cost_price,
      year: factory.year,
      car_model: factory.car_model
    )

    assemble(car)
  end

  private

  def assemble(car)
    add_wheels(car)
    add_chassis(car)
    add_laser(car)
    add_computer(car)
    add_engine(car)
    add_seats(car)
  end

  def add_wheels(car)
    @wheels = car.create_wheel(name: Wheel::BRANDS.sample, stock: 4)
  end

  def add_chassis(car)
    @chassis = car.create_chassis(name: Chassis::TYPES.sample, stock: 1)
  end

  def add_laser(car)
    @laser = car.create_laser(name: 'Car Laser', stock: 1)
  end

  def add_computer(car)
    @computer = car.create_computer(name: 'Car Computer #{Factory::Car.generate_code}', stock: 1)
    generate_failures if has_failure
  end

  def add_engine(car)
    @engine = car.create_engine(name: Engine::TYPES.sample, stock: 1)
  end

  def add_seats(car)
    @seats = car.create_seat(name: Seat::TYPES.sample, stock: 2)
  end

  def has_failure
    random = rand(0..5)
    random == 3 ? true : false
  end

  def generate_failures
    quantity = rand(1..5)
    failures = Factory::Car::FAILURES.shuffle
    0..quantity.times do |failure|
      @computer.failures.create(
        location: failures.shift
      )
    end
  end
end
