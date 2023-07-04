class Notification < ApplicationRecord
  DEFAULT_CASES = { toall: -1, toadmins: -2 }.freeze

  validates :to, presence: true, inclusion: { in: ->(record) { record.class::DEFAULT_CASES.values } }
end