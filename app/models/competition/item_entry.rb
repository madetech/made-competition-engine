module Competition
  class ItemEntry < ActiveRecord::Base
    belongs_to                      :item, :foreign_key => :competition_item_id
    accepts_nested_attributes_for   :item, :allow_destroy => true

    has_many                        :item_entry_additional_fields,
                                    :foreign_key => :competition_item_entry_id
    accepts_nested_attributes_for   :item_entry_additional_fields,
                                    :allow_destroy => true

    attr_accessible                 :first_name,
                                    :last_name,
                                    :email,
                                    :address_1,
                                    :address_2,
                                    :city,
                                    :county,
                                    :postcode,
                                    :country,
                                    :competition_item_id,
                                    :item,
                                    :created_at

    validates_format_of             :email,
                                    :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

    validates_uniqueness_of         :email,
                                    :scope => :competition_item_id,
                                    :unless => :monthly_competition?

    validates                       :email,
                                    :"competition/competition_validators/monthly_entry_limit" => true,
                                    :if => :monthly_competition?

    validates_presence_of           :first_name,
                                    :last_name,
                                    :address_1,
                                    :city,
                                    :postcode,
                                    :country,
                                    :competition_item_id

    private
    def monthly_competition?
      !item.nil? and item.monthly
    end
  end
end
