import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.remove();
    }, 5000); // removes after 5 seconds
  }
}
