class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all.order(:gender, :varsity)

    respond_to do |format|
      format.html
      format.json
      format.pdf do
        #pdf = TeamPdf.new(@teams, { :skip_page_creation => :true })
        pdf = TeamsPdf.new(@teams, { :skip_page_creation => :true })
        send_data pdf.render, filename: "teams.pdf", type: "application/pdf", disposition: "inline"
      end
    end

  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @coaches = CoachesTeam.select("*").joins(:coach).where(:team_id => params[:id])
    @athletes = AthletesTeam.select("*").joins(:athlete).where(:team_id => params[:id])
    @jerseycount = AthletesTeam.select("*").joins(:athlete).where(:team_id => params[:id]).where.not(jerseynumber: [nil, '']).count
    @team = Team.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = TeamPdf.new(@team)
        #pdf = TeamsPdf.new(@team, { :skip_page_creation => :false, :margin => [75, 50, 25, 50] })
        send_data pdf.render, filename: "team_#{@team.id}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    ##  Check for duplicates ...
#    team = Team.where(:name => params[:team][:name],
#        :active => params[:team][:active],
#        :url => params[:team][:url],
#        :twitter => params[:team][:twitter],
#        :suffix => params[:team][:suffix],
#        :gender => params[:team][:gender],
#        :varsity => params[:team][:varsity],
#        :season => params[:team][:season],
#        :sport_id => params[:team][:sport_id])
    team = Team.where(team_params)
    

    ##  If the team exists, return with an alert
    if team.count != 0
      return redirect_to page_path('admin/team'), alert: 'Team already exists.'
    end

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :active, :url, :twitter, :suffix, :gender, :varsity, :season, :sport_id, :teampicurl, :showgender)
    end
end
