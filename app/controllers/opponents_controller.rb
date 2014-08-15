class OpponentsController < ApplicationController
  before_action :set_opponent, only: [:show, :edit, :update, :destroy]

  # GET /opponents
  # GET /opponents.json
  def index
    @opponents = Opponent.all
  end

  # GET /opponents/1
  # GET /opponents/1.json
  def show
  end

  # GET /opponents/new
  def new
    @opponent = Opponent.new
  end

  # GET /opponents/1/edit
  def edit
  end

  # POST /opponents
  # POST /opponents.json
  def create
    @opponent = Opponent.new(opponent_params)

    respond_to do |format|
      if @opponent.save
        format.html { redirect_to @opponent, notice: 'Opponent was successfully created.' }
        format.json { render :show, status: :created, location: @opponent }
      else
        format.html { render :new }
        format.json { render json: @opponent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opponents/1
  # PATCH/PUT /opponents/1.json
  def update
    respond_to do |format|
      if @opponent.update(opponent_params)
        format.html { redirect_to @opponent, notice: 'Opponent was successfully updated.' }
        format.json { render :show, status: :ok, location: @opponent }
      else
        format.html { render :edit }
        format.json { render json: @opponent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opponents/1
  # DELETE /opponents/1.json
  def destroy
    @opponent.destroy
    respond_to do |format|
      format.html { redirect_to opponents_url, notice: 'Opponent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opponent
      @opponent = Opponent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opponent_params
      params.require(:opponent).permit(:name, :mascot, :homevenue, :conferenceopponent)
    end
end
