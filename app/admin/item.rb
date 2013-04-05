if defined?(ActiveAdmin) and Competition.config.engine_active_admin
  ActiveAdmin.register Competition::Item do
    controller do
      cache_sweeper Competition.config.cache_sweeper if Competition.config.cache_sweeper
    end

    action_item :only => :index do
      link_to "View Competitions on site", competition_path
    end

    action_item :only => :show do
      link_to "View Competition on site", competition_new_path(competition_item.url)
    end

    menu :label => 'Competitions'

    index do
      column :title
      column :created_at
      column :updated_at

      default_actions
    end

    filter :title
    filter :description
    filter :start_at
    filter :end_at

    form do |f|
      f.inputs "Competition" do
        f.input :title,         :wrapper_html => { :class => "default" }
        f.input :description,   :wrapper_html => { :class => "default" }
        f.input :image,         :wrapper_html => { :class => "default" }, :as => :file,
                                :hint => f.template.image_tag(f.object.image.url(:thumb))
        f.input :order,         :hint => 'Order that the competition appears in on the site'
        f.input :start_at,      :wrapper_html => { :class => "default" }, :as => :datepicker
        f.input :end_at,        :wrapper_html => { :class => "default" }, :as => :datepicker
      end

      f.inputs "Additional Fields" do
        f.has_many :item_additional_fields do |f_items|
          f_items.input  :label
          f_items.input  :field_type, :as => :select,
                         :collection => Competition::ItemAdditionalField.field_types
        end
      end

      f.actions
    end

    action_item :only => :show do
      link_to "Download Entries", entries_admin_competition_item_path(params[:id], :format => :csv)
    end

    member_action :entries do
      respond_to do |format|
        format.csv { render text: Competition::Item.find(params[:id]).populateEntriesCsv }
      end
    end
  end
end
