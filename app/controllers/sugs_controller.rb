class SugsController < ApplicationController
  before_action :set_sug, only: [:show, :edit, :update, :destroy]

  # GET /sugs
  # GET /sugs.json
  def index
    @sugs = Sug.all
  end

  # GET /sugs/1
  # GET /sugs/1.json
  def show
  end

  # GET /sugs/new
  def new
    @sug = Sug.new
  end

  # GET /sugs/1/edit
  def edit
  end

  # POST /sugs
  # POST /sugs.json
  def create
    @sug = Sug.new(sug_params)

    respond_to do |format|
      if @sug.save
        format.html { redirect_to @sug, notice: 'Sug was successfully created.' }
        format.json { render :show, status: :created, location: @sug }
      else
        format.html { render :new }
        format.json { render json: @sug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sugs/1
  # PATCH/PUT /sugs/1.json
  def update
    respond_to do |format|
      if @sug.update(sug_params)
        format.html { redirect_to @sug, notice: 'Sug was successfully updated.' }
        format.json { render :show, status: :ok, location: @sug }
      else
        format.html { render :edit }
        format.json { render json: @sug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sugs/1
  # DELETE /sugs/1.json
  def destroy
    @sug.destroy
    respond_to do |format|
      format.html { redirect_to sugs_url, notice: 'Sug was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sug
      @sug = Sug.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sug_params
      params.require(:sug).permit(:name, :description, :sugurl, :active)
    end
end
