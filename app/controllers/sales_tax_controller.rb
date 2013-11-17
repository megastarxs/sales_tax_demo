class SalesTaxController < ApplicationController
  def compute
    # Intilize SalesTaxModel directly from params and respond with the json
    render json: SalesTaxModel.new(params[:item].values)
  end
end
