class TrainingRecordsController < ApplicationController
before_action :set_training_record, only: [:destroy, :edit, :update]

  def index
    @training_records = TrainingRecord.all
  end

  def new
    @training_record = TrainingRecord.new
  end

  def create
    TrainingRecord.create(trainingrecord_params)
  end

  def destroy
    @training_record.destroy
  end
 
  def edit
  end

  def update
    @training_record.update(trainingrecord_params)
  end

  private

  def trainingrecord_params
    params.require(:training_record).permit(:date, :training_event, :training_weight, :reps, :set)
  end

  def set_training_record
    @training_record = TrainingRecord.find(params[:id])
  end
end
