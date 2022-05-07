import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "arrow"]

  toggle() {
    this.sidebarTarget.classList.toggle("hidden");
    this.arrowTarget.classList.toggle("hidden");
  }
}
