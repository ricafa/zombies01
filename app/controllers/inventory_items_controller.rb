class InventoryItemsController < ApplicationController
  before_action :set_inventory_item, only: [:show, :update, :destroy]

 # GET /items
  def index
    @inventory_items = InventoryItem.all

    render json: @inventory_items
  end

  # GET /items/1
  def show
    render json: @inventory_item
  end

  # PATCH/PUT /inventory_items/1
  def update
    if @inventory_item.update(inventory_item_params)
      render json: @inventory_item
    else
      render json: @inventory_item.errors, status: :unprocessable_entity
    end
  end

  #POST json
  def trade
    #binding.pry
    errors = []
    trade_items = trade_items_params[:trade_items]

    if trade_items.nil?
      errors << (I18n.t 'controllers.inventory_items.empty_params') 
    elsif trade_items.length != 2
      errors << (I18n.t 'controllers.inventory_items.missing_params') 
    end

    if errors.length <= 0 
      render json: (InventoryItem.trade trade_items_params)
    else
      render json: {done: false, msg: errors[0]}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_item
      @inventory_item = InventoryItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def inventory_item_params
      params.require(:inventory_item).permit(:survivor_id, :item_id, :qtt)
    end

    def trade_items_params
      permitted = params.require(:trade_items).permit(trade_items: [:survivor_id, items:[:item, :qtt]])
      permitted.to_h || {}
    end
end
