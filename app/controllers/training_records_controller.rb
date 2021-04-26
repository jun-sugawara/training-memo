class TrainingRecordsController < ApplicationController
  before_action :find_training_record, only: [:destroy, :edit, :update]
  before_action :move_to_top

  def index
    @training_records = TrainingRecord.all
  end

  def new
    @training_record = TrainingRecord.new
  end
  
  def next   
    @training_record = TrainingRecord.new(trainingrecord_params)
    render :new if @training_record.invalid?
  end
  
  # def confirm
  #   @training_record = TrainingRecord.new(trainingrecord_params)
  #   render :new and return if params[:back]
  # render :next if @training_record.invalid?(:confirm)
  # end
  
  def create  
    @training_record = TrainingRecord.new(trainingrecord_params)
    if @training_record.invalid?(:next)
       render :next 
    else @training_record.save
    redirect_to user_path(current_user.id), notice: "保存が完了しました" 
    end
  end

  def show
    @training_record = TrainingRecord.find_by(id: params[:id])
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
    else
      render :edit
    end
  end


  private

  def trainingrecord_params
    params.require(:training_record).permit(:date, :training_event, :training_weight, :reps, :set).merge(user_id: current_user.id)
  end

  def find_training_record
    @training_record = TrainingRecord.find(params[:id])
  end

  def move_to_top
    unless user_signed_in?
      redirect_to root_path
    end
  end

end
