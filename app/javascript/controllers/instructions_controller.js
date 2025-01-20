import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const placeholders = ["Where would you like to go", "What would you like to do", "Am excited, let's plan your trip together"]
    this.element.placeholder = placeholders[Math.floor(Math.random() * placeholders.length)]
    setInterval(() => {
      this.element.placeholder = placeholders[Math.floor(Math.random() * placeholders.length)]
    }, 5000)
  }
}
