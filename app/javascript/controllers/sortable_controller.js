import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs'
import Rails from '@rails/ujs'

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this)
    })
  }

  onEnd(event) {
    let id = event.item.dataset.sortableId
    let data = new FormData()
    data.append("position", event.newIndex + 1)

    Rails.ajax({
      url: this.data.get("url").replace(":id", id),
      type: 'PATCH',
      data: data
    })
  }
}
