class EmptyStateComponentPreview < ViewComponent::Preview
  # @param title
  # @param icon select [inbox, clock, check]
  def basic(title: "No messages", icon: "inbox")
    render EmptyStateComponent.new(title, icon)
  end

  # @param title
  # @param icon select [inbox, clock, check]
  # @param body
  def with_body(title: "No messages", icon: "inbox", body: "Send a message to get started.")
    render EmptyStateComponent.new(title, icon, body:)
  end

  # @param title
  # @param icon select [inbox, clock, check]
  # @param cta_icon select [mail, lock_open]
  # @param cta
  def with_button(title: "No messages", icon: "inbox", cta_icon: "mail", cta: "Send message")
    render EmptyStateComponent.new(title, icon, cta:, cta_path: "#", cta_icon:)
  end

  # @param title
  # @param icon select [inbox, clock, check]
  # @param body
  # @param cta_icon select [mail, lock_open]
  # @param cta
  def with_body_and_buton(title: "No messages", icon: "inbox", body: "Send a message to get started.", cta_icon: "mail", cta: "Send message")
    render EmptyStateComponent.new(title, icon, body:, cta:, cta_path: "#", cta_icon:)
  end
end
