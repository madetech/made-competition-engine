module Competition
	class CompetitionController < Competition::ApplicationController
     layout 'application'

		def index
			@competition_items = Competition::Item.getAllLiveCompetitions
		end

		def new
			@params_slug = params[:slug]
			@competition_item = Competition::Item.find_by_slug(@params_slug)
			@item_entry = Competition::ItemEntry.new

			if !@competition_item.isLive
				render :action => :expired
			elsif @competition_item.nil?
				redirect_to :action => :index
			end
		end

		def create
			@params_slug = params[:slug]
			@params_item_entry = params[:item_entry]
			@params_item_additional_entry = params[:item_entry_additional_field]
			@competition_item = Competition::Item.find_by_slug(@params_slug)
			@item_entry = Competition::ItemEntry.new(@params_item_entry)
			@item_entry.competition_item_id = @competition_item.id

			if !@competition_item.isLive
				render :action => :expired
			elsif @item_entry.save and Competition::ItemEntryAdditionalField.create_from_form(@item_entry.id, @params_item_additional_entry)
				render :action => :complete
			else
				render :action => :new
			end
		end

	end
end
