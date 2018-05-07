class Topology < ApplicationRecord
  has_many :nodes
  has_many :links
end
