class SportsVenuesController < ApplicationController
  before_action :set_sports_venue, only: [:show, :edit, :update, :destroy]

  # GET /sports_venues
  # GET /sports_venues.json
  def index
    @sports_venues = SportsVenue.all.order(:venue_id)
  end

  # GET /sports_venues/1
  # GET /sports_venues/1.json
  def show
  end

  # GET /sports_venues/new
  def new
    @sports_venue = SportsVenue.new
  end

  # GET /sports_venues/1/edit
  def edit
  end

  # POST /sports_venues
  # POST /sports_venues.json
  def create
    @sports_venue = SportsVenue.new(sports_venue_params)

    respond_to do |format|
      if @sports_venue.save
        format.html { redirect_to @sports_venue, notice: 'Sports venue was successfully created.' }
        format.json { render :show, status: :created, location: @sports_venue }
      else
        format.html { render :new }
        format.json { render json: @sports_venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sports_venues/1
  # PATCH/PUT /sports_venues/1.json
  def update
    respond_to do |format|
      if @sports_venue.update(sports_venue_params)
        format.html { redirect_to @sports_venue, notice: 'Sports venue was successfully updated.' }
        format.json { render :show, status: :ok, location: @sports_venue }
      else
        format.html { render :edit }
        format.json { render json: @sports_venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sports_venues/1
  # DELETE /sports_venues/1.json
  def destroy
    @sports_venue.destroy
    respond_to do |format|
      format.html { redirect_to sports_venues_url, notice: 'Sports venue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sports_venue
      @sports_venue = SportsVenue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sports_venue_params
      params.require(:sports_venue).permit(:sport_id, :venue_id)
    end
end
