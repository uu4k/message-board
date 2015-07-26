class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update]
  
  def index
    @messages = Message.all
    @message = Message.new
  end
  
  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to root_path , notice: 'メッセージを保存しました'
    else
      @messages = Message.all
      flash.now[:alert] = 'メッセージの保存に失敗しました'
      render 'index'
    end
  end
  
  def edit
  end
  
  def update
    if @message.update(message_params)
      redirect_to root_path, notice: 'メッセージを編集しました'
    else
      render 'edit'
    end
  end
  
  private
  def message_params
    # params[:message]のパラメータで name , bodyのみを許可する。
    # 返り値は ex:) {name: "入力されたname" , body: "入力されたbody" }
    params.require(:message).permit(:name, :body)
  end
  
  def set_message
    @message = Message.find(params[:id])
  end
end
