 import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="itinerary-form"
export default class extends Controller {
  static targets = ['loader', 'message']

  async connect() {
    setTimeout(() => {
      this.loadItinerary()
    }, 10000)
  }

  async loadItinerary() {
    const id = this.data.get('id')
    let response = await fetch(`/itineraries/${id}/run.json`)
    const status = response.status
    if (status !== 200) {
      setTimeout(() => {
        this.loadItinerary()
      }, 10000)
      return
    }
    const data = await response.json()
    this.loaderTarget.classList.add('hidden')
    this.buildMessage(data)
  }

  buildMessage(data) {
    const message = 'Click here to view your itinerary'
    this.messageTarget.innerHTML = `<a class="py-4 px-12 bg-teal-500 hover:bg-teal-600 rounded text-white" href="${data.itinerary.url}" target="_blank">${message}</a>`
    this.messageTarget.classList.remove('hidden')
  }
}