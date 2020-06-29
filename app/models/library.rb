class Library < ApplicationRecord
  validates :name, presence: true
  validates :code, presence: true
  validates :key, presence: true
  validates :address, presence: true
  validates :tel, presence: true
  validates :url, presence: true
end
