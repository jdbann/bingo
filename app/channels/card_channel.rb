class CardChannel < ApplicationCable::Channel
  def subscribed
    card = Card.find_by(code: params[:code])
    stream_for card
  end

  def toggle_mark(data)
    card = Card.find_by(code: params[:code])
    card_call = card.card_calls.find_by(call_id: data["call_id"])
    card_call.update(marked: !card_call.marked)
    CardChannel.broadcast_to(card, call: card_call.attributes)
  end
end
