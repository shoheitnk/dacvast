# Cue Point コントローラ
class CuepointsController < ApplicationController
  before_action :set_cuepoint, only: [:edit, :update, :destroy]
  
  # 一覧
  def index
    @cuepoints = Cuepoint.all.order("created_at DESC")
  end

  # 新規
  def new
    @cuepoint = Cuepoint.new
  end

  # 作成
  def create
    @cuepoint = Cuepoint.new(cuepoint_params)
    if @cuepoint.save
      flash[:success] = 'キューポイントが登録されました。'
      redirect_to cuepoints_path
    else
      flash.now[:danger] = 'キューポイントを登録できませんでした。'
      render :new
    end
  end

  # 編集
  def edit
  end

  # 更新
  def update
    if @cuepoint.update(cuepoint_params)
      flash[:success] = 'キューポイントが更新されました。'
      redirect_to cuepoints_url
    else
      flash.now[:danger] = 'キューポイントが更新されませんでした。'
      render :edit
    end
  end

  # 削除
  def destroy
    @cuepoint.destroy
    flash[:success] = 'キューポイントを削除しました。'
    redirect_to cuepoints_path
  end

  private
    # キューポイント用パラメータ
    def cuepoint_params
      params.require(:cuepoint).permit(:name)
    end
    
    def set_cuepoint
      @cuepoint = Cuepoint.find(params[:id])
    end
end
