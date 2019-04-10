class Failure < ActiveRecord::Base
  belongs_to :computer

  scope :not_notified, -> { where(is_notified: false) }
end
