module Admin
  class CheckComponentPreview < ViewComponent::Preview
    # @!group

    def checked
      render Admin::CheckComponent.new("Delivered")
    end

    def unchecked
      render Admin::CheckComponent.new("Delivered", "Not yet delivered", checked: false)
    end

    # @!endgroup
  end
end
