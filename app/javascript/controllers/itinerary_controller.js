 import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="itinerary-form"
export default class extends Controller {
  static targets = ['loader', 'message']

  async connect() {
    setTimeout(() => {
      this.loadItinerary()
    }, 10000)

    this.loadItinerary()
  }

  async loadItinerary() {
    const id = this.data.get('id')
    let response = await fetch(`/itineraries/${id}.json`)
    const data = await response.json()
    this.loaderTarget.classList.add('hidden')
    this.buildMessage(data)
  }

  buildMessage(data) {
    const message = data.itinerary.messages[0].content[0].text.value
    this.messageTarget.innerHTML = `
      <div class="message">
        <p>${message}</p>
      </div>
    `
  }
}