module Competition
  class ItemImage < ActiveRecord::Base
    belongs_to          :item, :foreign_key => :competition_item_id

    attr_accessible     :image,
                        :order

    has_attached_file   :image, :styles => Competition.config.image_styles

    default_scope       :order => '`order` ASC'
  end
end
