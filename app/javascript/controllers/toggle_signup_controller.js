import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["loginForm", "signupForm"]

  toggle() {
    this.loginFormTarget.classList.toggle("hidden")
    this.signupFormTarget.classList.toggle("hidden")
  }
}
