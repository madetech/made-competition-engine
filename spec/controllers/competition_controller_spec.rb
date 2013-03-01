require 'spec_helper'

describe Competition::CompetitionController do

  it "should render the index template" do
    get(:index, use_route: :competition)
    response.should render_template("index")
  end

end