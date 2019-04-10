class Car < ActiveRecord::Base
  include AASM

  has_one :wheel
  has_one :chassis
  has_one :laser
  has_one :computer
  has_one :engine
  has_one :seat

  aasm :column => 'state' do
    state :sleeping, initial: true
    state :assembling, :connecting, :painting, :completed

    after_all_transitions :save_status_change

    event :run do
      transitions from: :sleeping, to: :assembling
    end

    event :connect do
      transitions from: :assembling, to: :connecting
    end

    event :paint do
      transitions from: :connecting, to: :painting
    end

    event :end do
      transitions from: :painting, to: :completed

      after do
        store_car_stock
      end
    end
  end

  def save_status_change
    self.state = aasm.to_state
    save
  end

  def store_car_stock
    factory_stock = FactoryStock.find_by(car_model: self.car_model)
    factory_stock.present? ? increment_stock(self, factory_stock) : register_new_stock(self)
  end

  def increment_stock(car, factory_stock)
    factory_stock.increment!(:stock)
    car.computer.failures.empty? && car.completed? ? increment_cars_ready(factory_stock) : increment_cars_with_failures(factory_stock)
  end

  def register_new_stock(car)
    car.computer.failures.empty? && car.completed? ? create_inital_stock_cars_ready(car) : create_inital_stock_with_failures(car)

  end

  def create_inital_stock_cars_ready(car)
    FactoryStock.create(car_model: car.car_model, stock: 1, cars_ready: 1)
  end

  def create_inital_stock_with_failures(car)
    FactoryStock.create(car_model: car.car_model, stock: 1, cars_with_failures: 1)
  end

  def increment_cars_ready(factory_stock)
    factory_stock.increment!(:cars_ready)
  end

  def increment_cars_with_failures(factory_stock)
    factory_stock.increment!(:cars_with_failures)
  end
end
