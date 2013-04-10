class AddTermsToCompetitionItem < ActiveRecord::Migration
  def change
    add_column :competition_items, :terms, :text
  end
end
