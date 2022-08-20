module Admin
  class BasicLinkComponentPreview < ViewComponent::Preview
    # @param title
    def default(title: "Click me!")
      render Admin::BasicLinkComponent.new(title, "#")
    end
  end
end
