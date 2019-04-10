require 'factory'

class RobotBuyer < ActiveJob::Base
  queue_as :default

  def perform(*args)
    select_cars
    buy_cars
  end

  private

  def select_cars
    cars_quantity = [*1..9].sample
    @cars_to_buy = Factory::Car::MODELS.sample(cars_quantity)
  end

  def buy_cars
    @cars_to_buy.map {|car| buy_car(car) }
  end

  def buy_car(car)
    car_to_buy = StoreStock.find_by(car_model: car)
    car_to_buy.present? && car_to_buy.stock > 0 ? create_order(car_to_buy) : log_event_no_store_stock(car)
  end

  def log_event_no_store_stock(car)
    puts "============= NOTIFICATION CAR WITHOUT STOCK =========="
    puts "Car #{car} was not stock at time of sell"
    puts "============== creating purchase request ============="
    create_pending_order(car)
  end

  def create_pending_order(car)
    request = Order.create(code: Factory::Car.generate_code, date: Date.today, buyer: 'Mr. Roboto', status: :pending)
    request.create_item(car: car, quantity: 1)
    reserve_stock(car)
  end

  def reserve_stock(car)
    car_to_buy = FactoryStock.find_by(car_model: car)
    car_to_buy.present? ? get_factory_stock(car_to_buy) : log_event_no_factory_stock(car)
  end

  def log_event_no_factory_stock(car)
    puts "============= NOTIFICATION CAR WITHOUT ANY STOCK =========="
    puts "Car #{car} was not store stock or factory stock at time of sell"
  end

  def get_factory_stock(car)
    car.decrement!(:stock) if car.stock > 0
    car.decrement!(:cars_ready) if car.cars_ready > 0
  end

  def create_order(car)
    order = Order.create(code: Factory::Car.generate_code, date: Date.today, buyer: 'Mr. Roboto', status: :delivered)
    order.create_item(car: car.car_model, quantity: 1)
    update_stock(car)
  end

  def update_stock(car)
    car.decrement!(:stock) if car.stock > 0
  end
end
