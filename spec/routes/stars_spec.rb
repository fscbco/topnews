RSpec.describe "routes for Stars", type: :routing do
  it "routes stars/create to the stars#create action" do
    expect(post("stars/create")).to route_to("stars#create")
  end

  it "routes stars/delete to the stars#delete action" do
    expect(post("stars/delete")).to route_to("stars#delete")
  end
end
