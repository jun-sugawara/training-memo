class BodyRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_body_record, only: [:destroy, :edit, :update]
  before_action :move_to_top, only: :edit
  before_action :where_body_record, only: [:index, :search]
  before_action :set_body_record, only: [:create, :month_graph, :week_graph]

  def index
  end

  def search
    @search_body_record = BodyRecord.new(body_params)
    @search_body_record = if @search_body_record.date.present?
                            BodyRecord.where('date = ? AND user_id = ?', @search_body_record.date.to_s, current_user.id)
                          else
                            BodyRecord.none
                          end
    render :index
  end

  def new
    @body_record = BodyRecord.new
  end

  def create
    if @body_record.save
      redirect_to user_path(current_user.id), notice: '保存が完了しました'
    else
      render :new
    end
  end

  def destroy
    redirect_to body_records_path, notice: '削除が完了しました' if @body_record.destroy
  end

  def edit
  end

  def update
    if @body_record.update(body_params)
      redirect_to body_records_path, notice: '編集が完了しました'
    else
      render :edit
    end
  end

  def graph
  end

  def month_graph
    @body_record = if @body_record.date.present?
                    BodyRecord.where('date >=  ? AND date <= ? AND user_id = ?', @body_record.date, @body_record.date >> 1, current_user.id  )
                   else
                    BodyRecord.none
                   end
    @weight_graph = []
    @fat_graph = []
    @body_record.each do |s|
      @data = [s.date.to_s, s.body_weight]
      @weight_graph <<  [s.date.to_s, s.body_weight]
      @fat_graph << [s.date.to_s, s.fat]
    end
    render :graph
  end

  def week_graph
    @body_record = if @body_record.date.present?
                      BodyRecord.where('date >=  ? AND date <= ? AND user_id = ?', @body_record.date, @body_record.date + 7, current_user.id  )
                    else
                      BodyRecord.none
                    end
    @weight_graph = []
    @fat_graph = []
    @body_record.each do |s|
      @data = [s.date.to_s, s.body_weight]
      @weight_graph <<  [s.date.to_s, s.body_weight]
      @fat_graph << [s.date.to_s, s.fat]
    end
    render :graph
  end


    private
    

  def body_params
    params.require(:body_record).permit(:date, :body_weight, :fat, :todays_condition).merge(user_id: current_user.id)
  end

  def find_body_record
    @body_record = BodyRecord.find(params[:id])
  end

  def move_to_top
    redirect_to root_path unless (current_user.id == @body_record.user_id)
  end

  def where_body_record
    @body_record = BodyRecord.where('user_id = ?', current_user.id).order(date: :desc).limit(1)
  end

  def set_body_record
    @body_record = BodyRecord.new(body_params)
  end

  
end
