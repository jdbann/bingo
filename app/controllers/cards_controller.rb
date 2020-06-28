class CardsController < ApplicationController
  def index; end

  def create
    @card = Card.find_by(code: card_params[:code])
    redirect_to @card
  end

  def show
    @card = Card.find_by(code: params[:id])
  end

  private

  def card_params
    params.require(:card).permit(:code)
  end
end
