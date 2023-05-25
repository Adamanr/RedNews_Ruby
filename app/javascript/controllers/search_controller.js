import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["find"]

  find() {
    let search = this.findTarget.value
    if (search == "") {
      window.location.href = "http://127.0.0.1:3000/news/find/all" + search
    } else {
      window.location.href = "http://127.0.0.1:3000/news/find/" + search
    }

  }
}
