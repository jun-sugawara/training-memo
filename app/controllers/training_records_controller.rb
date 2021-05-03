class TrainingRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_training_record, only: [:destroy, :edit, :update]

  def index
    @training_records = TrainingRecord.all
    @training_record = TrainingRecord.order(date: :desc).limit(1)
  end

  def search
    @training_records = TrainingRecord.all
    @training_record = TrainingRecord.new(trainingrecord_params)
    if @training_record.date.present?
      @training_record = TrainingRecord.where('date = ?', "#{@training_record.date}}")
    else
      @training_record = TrainingRecord.none
    end
      render :index
  end

  def new
    @training_record = TrainingRecord.new
  end
  
  def next   
    @training_record = TrainingRecord.new(trainingrecord_params)
    render :new if @training_record.invalid?
  end
  
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

end
