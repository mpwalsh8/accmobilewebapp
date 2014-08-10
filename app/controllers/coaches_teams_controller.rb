class CoachesTeamsController < ApplicationController
  before_action :set_coaches_team, only: [:show, :edit, :update, :destroy]

  # GET /coaches_teams
  # GET /coaches_teams.json
  def index
    @coaches_teams = CoachesTeam.all
  end

  # GET /coaches_teams/1
  # GET /coaches_teams/1.json
  def show
  end

  # GET /coaches_teams/new
  def new
    @coaches_team = CoachesTeam.new
  end

  # GET /coaches_teams/1/edit
  def edit
  end

  # POST /coaches_teams
  # POST /coaches_teams.json
  def create
    @coaches_team = CoachesTeam.new(coaches_team_params)

    respond_to do |format|
      if @coaches_team.save
        format.html { redirect_to @coaches_team, notice: 'Coaches team was successfully created.' }
        format.json { render :show, status: :created, location: @coaches_team }
      else
        format.html { render :new }
        format.json { render json: @coaches_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coaches_teams/1
  # PATCH/PUT /coaches_teams/1.json
  def update
    respond_to do |format|
      if @coaches_team.update(coaches_team_params)
        format.html { redirect_to @coaches_team, notice: 'Coaches team was successfully updated.' }
        format.json { render :show, status: :ok, location: @coaches_team }
      else
        format.html { render :edit }
        format.json { render json: @coaches_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coaches_teams/1
  # DELETE /coaches_teams/1.json
  def destroy
    @coaches_team.destroy
    respond_to do |format|
      format.html { redirect_to coaches_teams_url, notice: 'Coaches team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coaches_team
      @coaches_team = CoachesTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coaches_team_params
      params.require(:coaches_team).permit(:team_id, :coach_id, :headcoach)
    end
end
