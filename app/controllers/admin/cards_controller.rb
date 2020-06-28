module Admin
  class CardsController < ApplicationController
    before_action :set_round, only: %i[index create]

    def index; end

    def create
      @round.cards.create
      redirect_to admin_round_cards_path(@round)
    end

    private

    def set_round
      @round = Round.find(params[:round_id])
    end
  end
end
