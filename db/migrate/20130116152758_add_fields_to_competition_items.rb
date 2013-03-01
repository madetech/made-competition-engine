class AddFieldsToCompetitionItems < ActiveRecord::Migration
	def change
		add_column :competition_items, :description, :text
		add_column :competition_items, :start_at, :datetime
		add_column :competition_items, :end_at, :datetime
		add_column :competition_items, :image_file_name, :string
		add_column :competition_items, :image_content_type, :string
		add_column :competition_items, :image_file_size, :integer
		add_column :competition_items, :image_updated_at, :datetime
	end
end
