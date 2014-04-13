class Order < ActiveRecord::Base

  belongs_to :frame

  validates :customer_name, :customer_email, :description, :price, :frame_id, presence: true
  validate :completion_date_must_be_in_the_past

  scope :unfinished, -> { where(completed_on: nil) }

  def self.paid
    where.not(paid_for_on: nil)
  end

  def self.unpaid
    where(paid_for_on: nil)
  end

  private

  def completion_date_must_be_in_the_past
    errors.add(:completed_on, 'should not be in the future.') if completed_on && completed_on > Time.now
  end

end
