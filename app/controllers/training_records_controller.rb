class TrainingRecordsController < ApplicationController
  def index
    @training_records = TrainingRecord.all
  end

  def new
    @training_record = TrainingRecord.new
  end

  def create
    TrainingRecord.create(trainingrecord_params)
  end

  private
  def trainingrecord_params
    params.require(:training_record).permit(:date, :training_event, :training_weight, :reps, :set)
  end
end
