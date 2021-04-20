class BodyRecordsController < ApplicationController
  before_action :set_body_record, only: [:destroy, :edit, :update]

  def index
    @body_records = BodyRecord.all
  end

  def new
    @body_record = BodyRecord.new
  end

  def create
    @body_record = BodyRecord.new(body_params)
    if @body_record.save
      redirect_to user_path(current_user.id), notice: "保存が完了しました"
    else
      render :new
    end
  end

  def destroy
    if body_record.destroy
      redirect_to training_records_path, notice: "削除が完了しました"
    end
  end

  def edit
  end

  def update
    if @body_record.update(body_params)
      redirect_to training_records_path, notice: "編集が完了しました"
    else
      render :edit
    end
  end

  private

  def body_params
    params.require(:body_record).permit(:date, :body_weight, :fat, :todays_condition).merge(user_id: current_user.id)
  end

  def set_body_record
    @body_record = BodyRecord.find(params[:id])
  end
end
