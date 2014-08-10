class AthletesTeamsController < ApplicationController
  before_action :set_athletes_team, only: [:show, :edit, :update, :destroy]

  # GET /athletes_teams
  # GET /athletes_teams.json
  def index
    @athletes_teams = AthletesTeam.all
  end

  # GET /athletes_teams/1
  # GET /athletes_teams/1.json
  def show
  end

  # GET /athletes_teams/new
  def new
    @athletes_team = AthletesTeam.new
  end

  # GET /athletes_teams/1/edit
  def edit
  end

  # POST /athletes_teams
  # POST /athletes_teams.json
  def create
    @athletes_team = AthletesTeam.new(athletes_team_params)

    respond_to do |format|
      if @athletes_team.save
        format.html { redirect_to @athletes_team, notice: 'Athletes team was successfully created.' }
        format.json { render :show, status: :created, location: @athletes_team }
      else
        format.html { render :new }
        format.json { render json: @athletes_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /athletes_teams/1
  # PATCH/PUT /athletes_teams/1.json
  def update
    respond_to do |format|
      if @athletes_team.update(athletes_team_params)
        format.html { redirect_to @athletes_team, notice: 'Athletes team was successfully updated.' }
        format.json { render :show, status: :ok, location: @athletes_team }
      else
        format.html { render :edit }
        format.json { render json: @athletes_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /athletes_teams/1
  # DELETE /athletes_teams/1.json
  def destroy
    @athletes_team.destroy
    respond_to do |format|
      format.html { redirect_to athletes_teams_url, notice: 'Athletes team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_athletes_team
      @athletes_team = AthletesTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def athletes_team_params
      params.require(:athletes_team).permit(:athlete_id, :team_id, :captain, :jerseynumber, :position)
    end
end
