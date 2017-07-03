# レポート関連コントローラ
class ResultsController < ApplicationController
  # 結果一覧表示
  def index
    @results = Result.all.order(:cuepoint_id, :campaign_id)
  end

  # 結果追加
  def record
    @campaign = Campaign.find(params[:id])
    @cuepoint = Cuepoint.find(params[:id])
    send_data(Base64.decode64('R0lGODlhAQABAPAAAAAAAAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=='),
      type: 'image/gif', disposition: 'inline')
  end
end
