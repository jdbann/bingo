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

    this.updateCssVariables()
  }

  cableConnected() {
    this.statusTarget.style.display = "none"
  }

  cableReceived(data) {
    if (data.hidden == true) {
      this.removeCall(data)
    } else {
      if (this.callTargets.find(call => call.dataset.callId == data.id) == null) {
        this.addCall(data)
      }
    }
    this.updateCssVariables()
  }

  addCall({ id, name }) {
    const node = document.createElement("li")
    const textNode = document.createTextNode(name)
    node.dataset.callId = id
    node.dataset.target = "round.call"
    node.classList.add("marquee-item")
    node.appendChild(textNode)
    this.listTarget.appendChild(node)
  }

  removeCall({ id }) {
    this.callTargets.forEach(element => {
      if (parseInt(element.dataset.callId) == id) {
        element.remove()
      }
    })
  }

  updateCssVariables() {
    this.element.style.setProperty("--screen-width", this.element.offsetWidth)
    this.element.style.setProperty("--marquee-width", this.listTarget.offsetWidth)
    this.element.style.setProperty("--duration", this.data.get("duration"))
  }
}
