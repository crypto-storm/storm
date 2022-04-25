import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "cross", "burger"]

  toggleNavbar() {
    this.toggleTarget.classList.toggle("hidden");
    this.burgerTarget.classList.toggle("hidden");
    this.crossTarget.classList.toggle("hidden");
  }
}
