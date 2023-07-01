class Notification < ApplicationRecord
  enum to: {toall: -1, toadmins: -2}
end
