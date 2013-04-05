class RemoveAgreeTermsFromCompetitionItemEntries < ActiveRecord::Migration
  def change
    remove_column :competition_item_entries, :agree_terms
  end
end
