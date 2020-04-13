class CallsController < ApplicationController
  before_action :set_call, only: %i[show edit update destroy]

  def index
    @calls = Call.all
  end

  def show; end

  def new
    round = Round.find(params[:round_id])
    @call = round.calls.new
  end

  def edit; end

  def create
    round = Round.find(params[:round_id])
    @call = round.calls.new(call_params)

    if @call.save
      RoundChannel.broadcast_to(round, call: @call.attributes)
      redirect_to round, notice: "Call was successfully created."
    else
      render :new
    end
  end

  def update
    if @call.update(call_params)
      RoundChannel.broadcast_to(@call.round, call: @call.attributes)
      redirect_to @call.round, notice: "Call was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @call.destroy
    RoundChannel.broadcast_to(@call.round, call: { id: @call.id, hidden: true })
    redirect_to @call.round, notice: "Call was successfully destroyed."
  end

  private

  def set_call
    @call = Call.find(params[:id])
  end

  def call_params
    params.require(:call).permit(:name, :round_id, :hidden)
  end
end
