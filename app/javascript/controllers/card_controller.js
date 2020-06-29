import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ["call"]

  connect() {
    this.cardCode = this.data.get("code")
    this.channel = consumer.subscriptions.create(
      {
        channel: "CardChannel",
        code: this.data.get("code")
      }, {
        connected: this.cableConnected.bind(this),
        received: this.cableReceived.bind(this)
      }
    )
  }

  toggleMark(event) {
    const { target } = event
    this.channel.perform("toggle_mark", { call_id: target.dataset.callId })
  }

  cableConnected() {
  }

  cableReceived(data) {
    this.callTargets.forEach(call => {
      if (call.dataset.callId == data.call.call_id) {
        call.dataset.marked = data.call.marked
        call.classList.toggle("card__call--marked", data.call.marked)
      }
    })
  }
}
