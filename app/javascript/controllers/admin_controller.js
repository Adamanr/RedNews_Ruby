import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["edition"]

    async submit() {
        let id = this.editionTarget.value
        console.log(id)
        fetch("http://127.0.0.1:3000/admin/submit/" + id)
            .then(() => location.reload())
            .then((json) => console.log(json))
    }

    async delete() {
        let id = this.editionTarget.value
        console.log(id)
        fetch("http://127.0.0.1:3000/admin/delete/" + id)
            .then(() => location.reload())
            .then((json) => console.log(json))
    }
}
