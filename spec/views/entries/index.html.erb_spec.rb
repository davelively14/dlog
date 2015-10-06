require 'rails_helper'

RSpec.describe "entries/index", type: :view do
  before(:each) do
    assign(:entries, [
      Entry.create!(
        :user => nil,
        :title => "Title",
        :body => "MyText",
        :slug => "Slug"
      ),
      Entry.create!(
        :user => nil,
        :title => "Title",
        :body => "MyText",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of entries" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
