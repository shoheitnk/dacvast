# 結果クラス
class Result < ApplicationRecord
  belongs_to :campaign
  belongs_to :cuepoint
  # validations

  private
    # initialize
    def zero_clear
      # TODO
    end
end
