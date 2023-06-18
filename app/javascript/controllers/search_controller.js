import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["find", "users", "articles"]

  find() {
    let search = this.findTarget.value
    if (search == "") {
      window.location.href = "https://redrust.ru/news/find/all" + search
    } else {
      window.location.href = "https://redrust.ru/news/find/" + search
    }
  }

  find_articles(){
    let search = this.articlesTarget.value
    if (search == "") {
      window.location.href = "https://redrust.ru/article/find/all" + search
    } else {
      window.location.href = "https://redrust.ru/article/find/" + search
    }

  }

  find_users() {
    let search = this.usersTarget.value
    if (search == "") {
      window.location.href = "http://redrust.ru/users/find/all" + search
    } else {
      window.location.href = "http://redrust.ru/users/find/" + search
    }
  }
}
