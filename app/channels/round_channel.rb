class RoundChannel < ApplicationCable::Channel
  def subscribed
    round = Round.find(params[:id])
    stream_for round
  end

  def unsubscribed
    stop_all_streams
  end
end
