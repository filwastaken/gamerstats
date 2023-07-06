class Notification < ApplicationRecord
  DEFAULT_CASES = { toall: -1, toadmins: -2 }.freeze
end