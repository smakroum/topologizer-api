class Task < ApplicationRecord
  belongs_to :topology, optional: true
end
