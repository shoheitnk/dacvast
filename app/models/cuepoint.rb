# キューポイントクラス
class Cuepoint < ApplicationRecord

# Relationships to cuepoints & result
has_and_belongs_to_many :campaigns
has_many :results

# Validations
validates :name, presence: true,
                 uniqueness: true,
                 length: { in: 5..20 }
end
