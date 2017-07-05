# キャンペーンクラス
class Campaign < ApplicationRecord
  
# Relationship to cuepoints & result
has_and_belongs_to_many :cuepoints
has_many :results, foreign_key: 'id', dependent: :destroy

# Validations
validates :name, presence: true,
                 uniqueness: true,
                 length: { in: 5..20 }
validates :limit_start, numericality: { only_integer: true,
                                        greater_than: 0, less_than: 10000 }
validates :movie_url, presence: true,
                      length: { in: 5..100 }
validate :start_end
  def start_end
    if start_at.present? && start_at > end_at
      errors.add(:start_at, "ダメです")
    end
  end


  # 有効なキャンペーン一覧を返す
  #  - 対象のCue Pointと紐付いている。
  #  - キャンペーンが開始していて、終了する前。
  #  - Resultのスタート数(count_start)がキャンペーンの制限(limit_start)以内。
  # @param [Cuepoint, #read] cuepoint キャンペーンの対象となっている Cue Point
  # @return [Array] 該当キャンペーンの配列
  
  def self.current_avaliable(cuepoint)
    campaigns = cuepoint.campaigns.where("start_at <= '#{Time.now}' AND end_at >= '#{Time.now}'").to_a
    #result.count_start >= campaign.limit_start
  end
end
