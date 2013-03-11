module Competition
  module ApplicationHelper
    module FormHelper
      def has_error(resource, field_name)
        if !resource.errors[field_name].blank?
          return true
        else
          return false
        end
      end

      def field_error_message(resource, field_name)
        resource.errors.full_message(field_name, resource.errors[field_name].first)
      end
    end
  end
end
