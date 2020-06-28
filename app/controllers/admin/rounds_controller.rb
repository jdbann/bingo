module Admin
  class RoundsController < ApplicationController
    before_action :set_round, only: %i[show edit update destroy]

    def index
      @rounds = Round.all
    end

    def show; end

    def new
      @round = Round.new
    end

    def edit; end

    def create
      @round = Round.new(round_params)

      if @round.save
        redirect_to [:admin, @round], notice: "Round was successfully created."
      else
        render :new
      end
    end

    def update
      if @round.update(round_params)
        if reset_calls_param
          @round.calls.each do |call|
            call.update(hidden: true)
            RoundChannel.broadcast_to(@round, call: call.attributes)
          end
        end
        RoundChannel.broadcast_to(@round, round: @round.attributes)
        redirect_to [:admin, @round], notice: "Round was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @round.destroy
      redirect_to admin_rounds_url, notice: "Round was successfully destroyed."
    end

    def screen
      @round = Round.find(params[:id])
      render :screen, layout: "layouts/screen"
    end

    private

    def set_round
      @round = Round.find(params[:id])
    end

    def round_params
      params.require(:round).permit(:name, :header, :footer)
    end

    def reset_calls_param
      params[:round][:reset_calls]
    end
  end
end
