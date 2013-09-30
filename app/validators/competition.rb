module Competition
  module CompetitionValidators
    class MonthlyEntryLimitValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        return if value.nil? or !record.new_record?

        entry_count = Competition::ItemEntry.where(
          :created_at => current_month,
          :email => "#{value}",
          :competition_item_id => record.competition_item_id).count

        if entry_count > 0
          record.errors[attribute] << I18n.t('validation.monthly_limit')
        end
      end

      private
      def current_month
        t = Time.now
        t.beginning_of_month..t.end_of_month
      end
    end
  end
end
