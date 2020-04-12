import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ['call', 'list', 'status'];

  connect() {
    this.roundId = this.element.dataset.roundId
    this.channel = consumer.subscriptions.create(
      {
        channel: 'RoundChannel',
        id: this.roundId
      }, {
        connected: this.cableConnected.bind(this),
        received: this.cableReceived.bind(this)
      }
    )
  }

  cableConnected() {
    this.statusTarget.style.display = "none"
  }

  cableReceived(data) {
    if (data.hidden == true) {
      console.log(data)
      this.callTargets.forEach(element => {
        if (parseInt(element.dataset.callId) == data.id) {
          console.log(element)
          element.remove()
        }
      })
    } else {
      const node = document.createElement("li")
      const textNode = document.createTextNode(data.name)
      node.dataset.callId = data.id
      node.dataset.target = "round.call"
      node.appendChild(textNode)
      this.listTarget.appendChild(node)
    }
  }
}
