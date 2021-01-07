class Transaction < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :transaction_groups, dependent: :destroy, foreign_key: 'transfer_id'
  has_many :groups, through: :transaction_groups
end
