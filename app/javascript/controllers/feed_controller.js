import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['content'];
    z
    connect() {
        this.showFeed();
    }

    showFeed() {
        let feed = document.getElementById("feed")
        let bookmarks = document.getElementById("bookmarks")

        bookmarks.classList.remove('underline')
        feed.classList.add('underline')
        this.loadContent('/users/1/feed');
    }

    showBookmarks() {
        let bookmarks = document.getElementById("bookmarks")
        let feed = document.getElementById("feed")

        feed.classList.remove('underline')
        bookmarks.classList.add('underline')
        this.loadContent('/users/1/bookmarks');
    }

    loadContent(url) {
        fetch(url)
            .then(response => response.text())
            .then(html => {
                this.contentTarget.innerHTML = html;
            });
    }
}
