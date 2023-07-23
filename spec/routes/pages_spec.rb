RSpec.describe "routes for Pages", type: :routing do
  it "routes / to the pages#home action" do
    expect(get("/")).to route_to("pages#home")
  end
end