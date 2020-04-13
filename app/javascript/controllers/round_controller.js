import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ['call', 'contents', 'list', 'status'];

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
    const announceDuration = parseFloat(this.data.get("announceDuration"))
    const textNode = document.createTextNode(name)

    const marqueeNode = document.createElement("li")
    marqueeNode.dataset.callId = id
    marqueeNode.dataset.target = "round.call"
    marqueeNode.classList.add("marquee-item")
    marqueeNode.appendChild(textNode)
    this.listTarget.appendChild(marqueeNode)

    const overlayNode = document.createElement("div")
    overlayNode.style.setProperty("--announce-duration", announceDuration)
    overlayNode.classList.add("marquee-overlay")
    overlayNode.appendChild(marqueeNode.cloneNode(true))
    this.element.appendChild(overlayNode)

    setTimeout(() => {
      this.listTarget.classList.add("marquee-stopped")
      window.requestAnimationFrame(() => {
        window.requestAnimationFrame(() => {
          this.listTarget.classList.remove("marquee-stopped")
        })
      })
    }, announceDuration * 900)

    setTimeout(() => {
      this.element.removeChild(overlayNode)
    }, announceDuration * 1000)
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
    this.element.style.setProperty("--marquee-width", this.contentsTarget.offsetWidth)
    this.element.style.setProperty("--duration", this.data.get("duration"))
  }
}
