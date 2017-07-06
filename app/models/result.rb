# 結果クラス
class Result < ApplicationRecord
  after_initialize :zero_clear
  belongs_to :campaign
  belongs_to :cuepoint

  private
    # initialize
    def zero_clear
      #選択してるcampaignのcount_startを呼び出す or ないならば０を入れる。
      self.count_start ||= 0
      self.count_complete ||= 0
    end
end
