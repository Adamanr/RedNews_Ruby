import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["edition"]

    async submit() {
        let id = this.editionTarget.value
        console.log(id)
        fetch("https://redrust.ru/admin/submit/" + id)
            .then(() => location.reload())
            .then((json) => console.log(json))
    }

    async delete() {
        let id = this.editionTarget.value
        console.log(id)
        fetch("https://redrust.ru/admin/delete/" + id)
            .then(() => location.reload())
            .then((json) => console.log(json))
    }
}
