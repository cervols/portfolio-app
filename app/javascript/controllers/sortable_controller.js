import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { patch } from "@rails/request.js"

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this)
    })
  }

  onEnd(event) {
    let sortableUpdateUrl = event.item.dataset.sortableUpdateUrl

    patch(sortableUpdateUrl, {
      body: JSON.stringify({position: event.newIndex + 1})
    })
  }
}
