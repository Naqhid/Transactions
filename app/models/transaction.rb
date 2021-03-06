# frozen_string_literal: true

class Transaction < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :amount, presence: true

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :transaction_groups, dependent: :destroy, foreign_key: 'transfer_id'
  has_many :groups, through: :transaction_groups

  scope :ordered_desc, -> { order(created_at: :desc) }
  scope :most_expensive_transaction, -> { where(amount: maximum(:amount)) }
  scope :most_cheapest_transaction, -> { where(amount: minimum(:amount)) }
end
