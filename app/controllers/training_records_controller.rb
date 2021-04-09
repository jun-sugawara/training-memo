class TrainingRecordsController < ApplicationController
  before_action :set_training_record, only: [:destroy, :edit, :update]

  def index
    @training_records = TrainingRecord.all
  end

  def new
    @training_record = TrainingRecord.new
  end

  def create
    @training_record = TrainingRecord.new(trainingrecord_params)
    if @training_record.save
      redirect_to training_records_path, notice: "保存が完了しました"
    else
      flash.now[:alert] = "保存に失敗しました"
      render :new
    end
  end

  def destroy
    if @training_record.destroy
      redirect_to training_records_path, notice: "削除が完了しました"
    end
  end

  def edit
  end

  def update
    if @training_record.update(trainingrecord_params)
      redirect_to training_records_path, notice: "編集が完了しました"
    end
  end

  private

  def trainingrecord_params
    params.require(:training_record).permit(:date, :training_event, :training_weight, :reps, :set)
  end

  def set_training_record
    @training_record = TrainingRecord.find(params[:id])
  end
end
