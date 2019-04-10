class Computer < ActiveRecord::Base
  belongs_to :car
  has_many :failures
end
