class AthletesController < ApplicationController
  before_action :set_athlete, only: [:show, :edit, :update, :destroy]
  before_action :set_athletes, only: [:purge]

  # GET /athletes
  # GET /athletes.json
  def index
    @athletes = Athlete.all.order(:lastname, :firstname)
  end

  # POST /athletes/import
  # POST /athletes/import.json
  def import
    if request.post?
      begin
        athletes = Athlete.import(params[:import][:file])
        redirect_to page_path('admin/athlete'), notice: sprintf("Athletes:  %d imported, %d skipped", athletes[:imported], athletes[:skipped])
      rescue
        redirect_to page_path('admin/athlete'), alert: "Invalid CSV file format."
      end
    end
  end

  # GET /athletes/1
  # GET /athletes/1.json
  def show
  end

  # GET /athletes/new
  def new
    @athlete = Athlete.new
  end

  # GET /athletes/1/edit
  def edit
  end

  # POST /athletes
  # POST /athletes.json
  def create
    @athlete = Athlete.new(athlete_params)

    respond_to do |format|
      if @athlete.save
        format.html { redirect_to @athlete, notice: 'Athlete was successfully created.' }
        format.json { render :show, status: :created, location: @athlete }
      else
        format.html { render :new }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /athletes/1
  # PATCH/PUT /athletes/1.json
  def update
    respond_to do |format|
      if @athlete.update(athlete_params)
        format.html { redirect_to @athlete, notice: 'Athlete was successfully updated.' }
        format.json { render :show, status: :ok, location: @athlete }
      else
        format.html { render :edit }
        format.json { render json: @athlete.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /athletes/1
  # DELETE /athletes/1.json
  def destroy
    @athlete.destroy
    respond_to do |format|
      format.html { redirect_to page_path('admin/athlete'), notice: 'Athlete was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PURGE /athletes
  # PURGE /athletes.json
  def purge
    session[:return_to] ||= request.referer
    c = @athletes.count
    @athletes.destroy_all
    respond_to do |format|
      #format.html { redirect_to :back, notice: "Athletes (#{c}) were successfully destroyed." }
      format.html { redirect_to athletes_url, notice: "Athletes (#{c}) were successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_athlete
      #logger.info(sprintf("set_athlete - %s::%s", __FILE__, __LINE__))
      # Make sure :id is numeric!  We'll use a RegExp to do so...
      if params[:id].match(/^\d+$/)
      #if params[:id].is_a? Integer
        @athlete = Athlete.find(params[:id])
      else
        redirect_to athletes_path, { notice: "Parameter (#{params[:id]}) is not numeric." }
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_athletes
      @athletes = Athlete.where(["gradyear = ?", params[:gradyear]])
      #logger.info(sprintf("set_athletes - %s::%s", __FILE__, __LINE__))
      #logger.info(@athletes.count)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def athlete_params
      params.require(:athlete).permit(:firstname, :middlename, :lastname, :nickname, :dob, :gradyear, :active, :height, :weight, :email, :twitter, :gender)
    end
end
