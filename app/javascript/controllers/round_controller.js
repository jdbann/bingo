import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ['call', 'contents', 'list', 'status', 'header', 'footer'];

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
    if (data.call != null) {
      this.handleCall(data.call)
    }
    if (data.round != null) {
      this.handleRound(data.round)
    }
  }

  handleCall(data) {
    if (data.hidden == true) {
      this.removeCall(data)
    } else {
      const call = this.callTargets.find(call => call.dataset.callId == data.id)
      if (call == null) {
        this.addCall(data)
      } else {
        this.updateCall(call, data)
      }
    }
    this.updateCssVariables()
  }

  handleRound({ header, footer }) {
    this.headerTarget.innerHTML = header
    this.footerTarget.innerHTML = footer
  }

  addCall({ id, name }) {
    const announceDuration = parseFloat(this.data.get("announceDuration"))
    const textNode = document.createTextNode(name)

    const marqueeNode = document.createElement("div")
    marqueeNode.dataset.callId = id
    marqueeNode.dataset.target = "round.call"
    marqueeNode.classList.add("marquee-item")
    marqueeNode.appendChild(textNode)

    const overlayNode = document.createElement("div")
    overlayNode.classList.add("marquee-overlay")
    overlayNode.appendChild(marqueeNode.cloneNode(true))
    this.element.appendChild(overlayNode)

    this.contentsTarget.classList.add("marquee-contents-hidden")

    setTimeout(() => {
      this.contentsTarget.classList.add("marquee-stopped")
      window.requestAnimationFrame(() => {
        window.requestAnimationFrame(() => {
          this.contentsTarget.classList.remove("marquee-stopped")
        })
      })
      this.contentsTarget.classList.remove("marquee-contents-hidden")
      this.listTarget.appendChild(marqueeNode)
    }, announceDuration * 900)

    setTimeout(() => {
      this.element.removeChild(overlayNode)
    }, announceDuration * 1000)
  }

  updateCall(call, { name }) {
    call.innerHTML = name
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
    this.element.style.setProperty("--announce-duration", this.data.get("announceDuration"))
  }
}
