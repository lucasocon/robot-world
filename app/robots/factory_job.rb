class FactoryJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Car.all.map {|car| next_stage(car) }
  end

  private

  def next_stage(car)
    if car.sleeping?
      car.run
    elsif car.assembling?
      car.connect
    elsif car.connecting?
      car.paint
    elsif car.painting?
      car.end
    end
  end
end
