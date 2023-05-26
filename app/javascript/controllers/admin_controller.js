import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["edition", "user"]

    async submit() {
        let id = this.editionTarget.value
        fetch("https://redrust.ru/admin/submit/" + id)
            .then(() => location.reload())
            .then((json) => console.log(json))
    }

    async delete() {
        let id = this.editionTarget.value
        fetch("https://redrust.ru/admin/delete/" + id)
            .then(() => location.reload())
            .then((json) => console.log(json))
    }

    add_admin() {
        let id = this.userTarget.value
        fetch("https://redrust.ru//admin/admin/" + id)
            .then(() => location.reload())
            .then((json) => console.log(json))
    }

    un_admin() {
        let id = this.userTarget.value
        fetch("https://redrust.ru//admin/unadmin/" + id)
            .then(() => location.reload())
            .then((json) => console.log(json))
    }

}
