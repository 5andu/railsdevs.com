module Admin
  class BasicLinkGroupComponentPreview < ViewComponent::Preview
    def default
      render Admin::BasicLinkGroupComponent.new do |group|
        group.with_link "First link", "#"
        group.with_link "Second link", "#"
      end
    end
  end
end
