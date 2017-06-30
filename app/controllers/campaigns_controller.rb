# キャンペーン用コントローラ
class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:edit, :update, :destroy]
  
  # 一覧表示
  def index
    unless params[:cuepoint_id]
      # TODO cuepointについては考えないで実装
      @campaigns = Campaign.all.order("created_at DESC")
    else
      # 下記はVAST URL呼び出しを想定
      # TODO
      campaigns = campaign.current_avaliable 
      response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
      response.headers['Access-Control-Allow-Methods'] = 'GET'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Credentials'] = 'true'
      headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type'
    end
  end

  # 新規
  def new
    @campaign = Campaign.new
    #@cuepoint = Cuepoint.all #チェックボックスの裏で呼び出しが必要？ 
  end

  # 作成
  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      flash[:success] = 'キャンペーンが登録されました。'
      redirect_to campaigns_url
    else
      flash.now[:danger] = 'キャンペーンを登録できませんでした。'
      render :new
    end
  end

  # 編集
  def edit
    # @cuepoints = @campain.cuepoints #newと同じ理由で。
  end

  # 更新
  def update
    if @campaign.update(campaign_params)
      flash[:success] = 'キャンペーンが更新されました。'
      redirect_to campaigns_url
    else
      flash.now[:danger] = "更新に失敗しました。"
      render :edit
    end
  end

  # 削除
  def destroy
    @campaign.destroy
    flash[:success] = 'キャンペーンを削除しました。'
    redirect_to campaigns_path
  end

  private
  
  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(:name, :start_at, :end_at, :limit_start, :movie_url)
  end
end