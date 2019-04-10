class GuardRobot < ActiveJob::Base
  queue_as :default

  def perform(*args)
    check_notifications
    check_stocks
  end

  private

  def check_stocks
    cars_ready = FactoryStock.where("cars_ready > 0")
    transfer_cars_ready(cars_ready) if cars_ready.present?
  end

  def transfer_cars_ready(cars)
    cars.map { |car| store_cars(car) }
  end

  def store_cars(car)
    store_stock = StoreStock.find_by(car_model: car.car_model)
    store_stock.present? ? register_income(store_stock) : create_income(car)
  end

  def register_income(store_stock)
    store_stock.increment!(:stock)
  end

  def create_income(car)
    StoreStock.create(car_model: car.car_model, stock: 1)
  end

  def check_notifications
    Failure.not_notified.map {|failure| send_notification(failure) }
  end

  def send_notification(failure)

    car = failure.computer.car

    message = "Car with ref. #{car.id} - #{car.car_model} has the next failure: \n"
    message += "- #{failure.location}\n"

    notification_delivered(failure)

    notifier = Slack::Notifier.new "https://hooks.slack.com/services/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", 
      channel: "#random",
      username: "GuardRobotNotifier"

    notifier.ping message
  end

  def notification_delivered(failure)
    failure.is_notified = true
    failure.save
  end
end
