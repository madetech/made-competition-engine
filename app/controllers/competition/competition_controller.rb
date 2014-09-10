module Competition
  class CompetitionController < Competition::ApplicationController
    layout 'application'
    helper Competition::ApplicationHelper::FormHelper

    def index
      @competition_items = Competition::Item.get_all_live_competitions
    end

    def new
      @competition_item = Competition::Item.find_by_url(params[:slug])
      @item_entry = Competition.config.competition_item_entry_class.new
      if !@competition_item.is_live?
        render :action => :expired
      elsif @competition_item.nil?
        redirect_to :action => :index
      end
    end

    def create
      @params_item_additional_entry = params[:item_entry_additional_field]
      @competition_item = Competition::Item.find_by_url(params[:slug])
      @item_entry = Competition.config.competition_item_entry_class.new(params[:item_entry])
      @item_entry.competition_item_id = @competition_item.id

      if !@competition_item.is_live?
        render :action => :expired
      elsif @competition_item.is_entered?(@item_entry, params[:item_entry_additional_field])
        redirect_to :action => :thanks
      else
        render :action => :new
      end
    end

    def thanks
      @competition_item = Competition::Item.find_by_url(params[:slug])
    end
  end
end
