import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['content', 'contents'];

    connect() {
        this.showFeed();
    }

    showFeed() {
        let id = this.contentsTarget.value
        console.log(id)
        let feed = document.getElementById("feed")
        let bookmarks = document.getElementById("bookmarks")

        if (bookmarks != null) {
            bookmarks.classList.remove('underline')
        }
        feed.classList.add('underline')
        this.loadContent('/users/' + id + '/feed');
    }

    showBookmarks() {
        let bookmarks = document.getElementById("bookmarks")
        let feed = document.getElementById("feed")
        let id = this.contentsTarget.value

        feed.classList.remove('underline')
        bookmarks.classList.add('underline')
        this.loadContent('/users/' + id + '/bookmarks');
    }

    loadContent(url) {
        fetch(url)
            .then(response => response.text())
            .then(html => {
                this.contentTarget.innerHTML = html;
            });
    }
}
