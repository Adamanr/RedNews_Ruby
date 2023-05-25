import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["like"]

    connect() {
        console.log("alikea")
    }

    like() {
        let id = this.likeTarget.value.split(/[ ,]+/);
        fetch("http://127.0.0.1:3000/article/like/" + id[0].toString() + "/" + id[1].toString())
            .then(() => location.reload())
            .then((json) => console.log(json))
    }

    unlike() {
        let id = this.likeTarget.value.split(/[ ,]+/);
        fetch("http://127.0.0.1:3000/article/unlike/" + id[0].toString() + "/" + id[1].toString())
            .then(() => location.reload())
            .then((json) => console.log(json))
    }
    bookmarks() {
        console.log("Book")
    }
}
