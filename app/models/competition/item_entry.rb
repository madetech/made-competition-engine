module Competition

  class ItemEntry < ActiveRecord::Base

    belongs_to :item, :foreign_key => :competition_item_id
    accepts_nested_attributes_for :item, :allow_destroy => true

    has_many :item_entry_additional_fields, :foreign_key => :competition_item_entry_id
    accepts_nested_attributes_for :item_entry_additional_fields, :allow_destroy => true

    attr_accessible :first_name,
                    :last_name,
                    :email,
                    :favourite_product,
                    :address_1,
                    :address_2,
                    :city,
                    :county,
                    :postcode,
                    :country,
                    :promotional_code,
                    :competition_item_id

    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_format_of :email, :with => /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i
    validates_uniqueness_of :email, :scope => :competition_item_id
    #validates_presence_of :favourite_product
    validates_presence_of :address_1
    #validates_presence_of :address_2
    validates_presence_of :city
    #validates_presence_of :county
    validates_presence_of :postcode
    validates_presence_of :country
    #validates_presence_of :promotional_code
    validates_presence_of :competition_item_id

  end

end
