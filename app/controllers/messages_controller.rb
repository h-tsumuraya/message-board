class MessagesController < ApplicationController
  
  # 事前処理（onlyで指定されたactionの場合だけ実行）
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
  #コメントアウトしても動く
  #def edit
  #end
  
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
    # destoryは失敗しないのか…？
    @message.destroy
    redirect_to root_path, notice: "メッセージを削除しました"
  end
  
  # 以下、プライベートメソッド
  private
  
  def message_params
    # ストロングパラメータ（リクエストパラメータをホワイトリスト形式で受け取る機能）
    # paramsに:messageキーが存在するか検証し、あれば:nameと:bodyの値を受け取る
    # :ageを追加
    params.require(:message).permit(:name, :body, :age)
  end
  
  def set_message
    # paramsから:idの値を取得し、そのidを元に検索する
    @message = Message.find(params[:id])
  end
  
end
