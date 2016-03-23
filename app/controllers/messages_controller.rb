class MessagesController < ApplicationController
  
  before_action :set_message, only: [:edit, :update, :destroy]
  
  def index
    @message = Message.new
    # すべて取得
    @messages = Message.all
  end
  
  # 作成
  def create
    @message = Message.new(message_params)
    
    if @message.save 
      redirect_to root_path , notice: "メッセージを保存しました"
    else 
      # 失敗したとき
      @messages = Message.all
      flash.now[:alert] = "メッセージの保存に失敗しました"
      render 'index'
    end
    
  end
  
  # 編集
  def edit
  end
  
  # 更新
  def update
    if @message.update(message_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: "メッセージを編集しました"
    else
      # 保存に失敗した場合は編集画面へ戻す
      render "edit"
    end
  end
  
  # 削除
  def destroy
    @message.destroy
    redirect_to root_path, notice: "メッセージを削除しました"
  end
  
  private
  
  def message_params
    params.require(:message).permit(:name, :body)
  end
  
  def set_message
    @message = Message.find(params[:id])
  end
  
end
