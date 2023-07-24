RSpec.describe "routes for Stories", type: :routing do
  it "routes / to the stories#home action" do
    expect(get("/")).to route_to("stories#home")
  end

  it "routes /starred to the stories#starred action" do
    expect(get("/starred")).to route_to("stories#starred")
  end
end