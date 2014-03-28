class Mentor::JobsController < ApplicationController
  layout 'mentor'
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = current_user.works
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = current_user.works.build
  end

  # GET /jobs/1/edit
  def edit

  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to mentor_job_path(@job), notice: 'Job was successfully created.' }
        format.json { render action: 'show', status: :created, location: @job }
      else
        format.html { render action: 'new' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to mentor_job_path(@job), notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to mentor_jobs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      begin
        @job = current_user.works.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to mentor_jobs_path, notice: '접근 권한이 없습니다.'
      rescue NoMethodError
        redirect_to root_path, notice: '멘토 등록은 063-650-1757로 연락 주세요^^'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:category, :title, :contents, :started_at, :finished_at, :working_time, :start_time, :finish_time, :learning_time, :level, :workers_count, :pay, :location, :address, :mentor_id, )
    end
end
