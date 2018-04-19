class SurvivorsController < ApplicationController
  before_action :set_survivor, only: [:show, :update, :destroy]

  # GET /survivors
  def index
    @survivors = Survivor.all

    render json: @survivors
  end

  # GET /survivors/1
  def show
    render json: @survivor
  end

  # POST /survivors
  def create
    @survivor = Survivor.new(survivor_params)
    #@survivor.inventory_items.create(inventory_item_attributes)
    if @survivor.save
      render json: @survivor.to_json(except: [
                                    :created_at, :updated_at, :infectqtt, :infected
                                    ], include: :inventory_items), status: :created, location: @survivor
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /survivors/1
  def update
    if @survivor.update(survivor_params)
      render json: @survivor.to_json(except: [:create_at, :update_at, :infectqtt, :infected], include: :inventory_items)
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  #GET contaminated
  def contaminated
    survivor = Survivor.find(params[:id])
    if survivor.mark_contamination_report
      render json: {msg: (I18n.t 'controllers.survivor.infected_message')}
    else
      render json: {msg: (I18n.t 'controllers.survivor.success_report_message')}
    end
  end

  # DELETE /survivors/1
  def destroy
    @survivor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survivor
      @survivor = Survivor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def survivor_params
      params.require(:survivor).permit(:name, :age, :gender, :latitude, :longitude, :infected, inventory_items_attributes: [:item_id, :qtt])
    end
end
