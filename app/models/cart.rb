# frozen_string_literal: true

class Cart < ApplicationRecord
  validates :name, presence: true
end
