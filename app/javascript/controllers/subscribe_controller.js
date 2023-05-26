import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["subscribe"]

    sub() {
        let id = this.subscribeTarget.value
        let data = id.split(/[ ,]+/)
        console.log(data)
        fetch("https://redrust.ru/editions/sub/" + data[0] + "/" + data[1])
            .then(() => location.reload())
            .catch((err) => alert(err))
    }

    unsub() {
        let id = this.subscribeTarget.value
        let data = id.split(/[ ,]+/)
        fetch("https://redrust.ru/editions/unsub/" + data[0] + "/" + data[1])
            .then(() => location.reload())
            .catch((err) => alert(err))
    }
}
