import { Modal } from "tailwindcss-stimulus-components";

export default class ExtendedModal extends Modal {
  connect() {
    super.connect()
    document.addEventListener('turbo:submit-end', this.handleSubmit)
  }

  handleSubmit = (e) => {
    if (e.detail.success) {
      super.close(e)
    }
  }
}

