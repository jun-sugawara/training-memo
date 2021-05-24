class TrainingRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_training_record, only: [:destroy, :edit, :update]
  before_action :move_to_top, only: :edit
  before_action :set_training_genre, except: [:new, :next, :create, :show, :destroy]
  before_action :set_training_record, only: [:search, :max_search, :next, :create]

  def index
    @training_record = TrainingRecord.where('user_id = ?', current_user.id).order(date: :desc).limit(1)
  end

  def search
    @training_record = if @training_record.date.present?
                         TrainingRecord.where('date = ? AND user_id = ?', @training_record.date.to_s, current_user.id)
                       else
                         TrainingRecord.none
                       end
    render :index
  end

  def max
    @training_record = TrainingRecord.where('user_id = ?', current_user.id).order(training_weight: :desc).limit(1)
  end

  def max_search
    @training_record = if @training_record.training_event.present?
                         TrainingRecord.where('training_event = ? AND user_id = ?', @training_record.training_event.to_s,
                                              current_user.id).order(training_weight: :desc).limit(1)
                       else
                         TrainingRecord.none
                       end
    render :max
  end

  def new
    @training_record = TrainingRecord.new
  end

  def next
    render :new if @training_record.invalid?
  end

  def create
    if @training_record.invalid?(:next)
      render :next
    else
      @training_record.save
      redirect_to user_path(current_user.id), notice: '保存が完了しました'
    end
  end

  def destroy
    redirect_to training_records_path, notice: '削除が完了しました' if @training_record.destroy
  end

  def edit
  end

  def update
    if @training_record.update(trainingrecord_params)
      redirect_to training_records_path, notice: '編集が完了しました'
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
    redirect_to root_path unless current_user.id == @training_record.user_id
  end

  def set_training_genre
    @training_genre = TrainingGenre.includes(:training_record)
  end

  def set_training_record
    @training_record = TrainingRecord.new(trainingrecord_params)
  end
end
