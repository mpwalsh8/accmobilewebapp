class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :set_opponentid, only: [:create, :update]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all.order(:eventdate)
  end

  # GET /events/1
  # GET /events/1.json
  def show
#logger.info(@event[:opponents].to_yaml)
#logger.info(@event[:opponents].count)
    @event.opponents.each do |o|
      if !o.blank?
        logger.info(o)
      end
    end

    x = @event.opponents.compact
    logger.info(x.count)
    x = @event.opponents.delete_if(&:blank?)
    logger.info(x.count)
logger.info(@event.to_yaml)
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def set_opponentid
      o = params[:event][:opponents].delete_if(&:blank?)
      if o.count == 1
        params[:event][:opponentid] = o.first
      else
        params[:event][:opponentid] = nil
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:teamid, :opponentid, :venueid, :eventlocation, :eventdate, :eventtime, :eventduration, :status, :notes, :description, :opponents => [])
    end
end
