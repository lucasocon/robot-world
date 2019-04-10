require 'factory'

class RobotSeller < ActiveJob::Base
  queue_as :default

  def perform(*args)
    check_pending_orders
  end

  private

  def check_pending_orders
    Order.pending.map { |request| check_stocks(request) }
  end

  def check_stocks(request)
    store = StoreStock.find_by(car_model: request.item.car)
    update_order(request) if store.present? && store.stock > 0
  end

  def update_order(request)
    request.update(status: :delivered)
  end
end
