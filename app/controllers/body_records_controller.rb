class BodyRecordsController < ApplicationController
  before_action :set_body_record, only: [:destroy, :edit, :update]

  def index
    @body_records = BodyRecord.all
  end

  def new
    @body_record = BodyRecord.new
  end

  def create
    BodyRecord.create(body_params)
  end

  def destroy
    @body_record.destroy
  end

  def edit
  end

  def update
    @body_record.update(body_params)
  end

  private

  def body_params
    params.require(:body_record).permit(:date, :body_weight, :fat, :todays_condition)
  end

  def set_body_record
    @body_record = BodyRecord.find(params[:id])
  end
end
