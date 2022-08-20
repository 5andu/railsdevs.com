module Admin
  module Tables
    class TableComponentPreview < ViewComponent::Preview
      def default
        render Admin::Tables::TableComponent.new do |table|
          table.with_header "Date"
          table.with_header "Description"
          table.with_header "Amount", align: :right

          table.with_row do |row|
            row.with_cell primary: true do
              "August 19, 2022"
            end
            row.with_cell do
              "Fathom analytics"
            end
            row.with_cell align: :right do
              "$14"
            end
          end

          table.with_row do |row|
            row.with_cell primary: true do
              "August 18, 2022"
            end
            row.with_cell do
              "Swag"
            end
            row.with_cell align: :right do
              "$48"
            end
          end

          table.with_row do |row|
            row.with_cell primary: true do
              "August 17, 2022"
            end
            row.with_cell do
              "HEY for domains"
            end
            row.with_cell align: :right do
              "$10"
            end
          end
        end
      end
    end
  end
end
