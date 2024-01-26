import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    const toast = bootstrap.Toast.getOrCreateInstance(this.element)
    toast.show()
  }
}
