class JoggingTimesController < ApplicationController
  before_action :set_jogging_time, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :authorize_user!, only: %i[edit update destroy]

  # GET /jogging_times or /jogging_times.json
  def index
    @start_date = params[:start_date]
    @end_date = params[:end_date]

    @jogging_times = if @start_date.present? && @end_date.present?
                      current_user.jogging_times.where(date: @start_date..@end_date)
                    else
                      current_user.jogging_times
                    end
  end
  
  # GET /jogging_times/1 or /jogging_times/1.json
  def show
  end

  # GET /jogging_times/new 
  def new
    @jogging_time = JoggingTime.new
  end

  # GET /jogging_times/1/edit
  def edit
  end

  # POST /jogging_times or /jogging_times.json
  def create
    @jogging_time = JoggingTime.new(jogging_time_params)
    @jogging_time.user = current_user
    @jogging_time.time = params[:jogging_time][:hours].to_i * 60 + params[:jogging_time][:minutes].to_i

    respond_to do |format|
      if @jogging_time.save
        format.html { redirect_to @jogging_time, notice: "Jogging time was successfully created." }
        format.json { render :show, status: :created, location: @jogging_time }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @jogging_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jogging_times/1 or /jogging_times/1.json
  def update
    @jogging_time.time = params[:jogging_time][:hours].to_i * 60 + params[:jogging_time][:minutes].to_i

    respond_to do |format|
      if @jogging_time.update(jogging_time_params)
        format.html { redirect_to @jogging_time, notice: "Jogging time was successfully updated." }
        format.json { render :show, status: :ok, location: @jogging_time }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @jogging_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jogging_times/1 or /jogging_times/1.json
  def destroy
    @jogging_time.destroy!

    respond_to do |format|
      format.html { redirect_to jogging_times_url, notice: "Jogging time was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /weekly_report 
  def weekly_report 
    @weekly_report = JoggingTime.weekly_averages(current_user) 
  end
  

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_jogging_time
    @jogging_time = JoggingTime.find(params[:id])
  end

  def authorize_user!
    unless @jogging_time.user == current_user || current_user.admin?
      redirect_to jogging_times_path, alert: "You are not authorized to perform this action."
    end
  end

  # Only allow a list of trusted parameters through.
  def jogging_time_params
    params.require(:jogging_time).permit(:date, :distance, :distance_unit)
  end
end


