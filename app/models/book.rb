class Book < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true
  validates :thumbnail_url, presence: true
  validates :status, presence: true
  enum status: %i( yet done )

  after_initialize :set_default, if: :new_record?

  def set_default
    self.status ||= :yet
  end
end
