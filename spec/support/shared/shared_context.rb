RSpec.shared_context "signed in user" do
  let(:user) { create(:user) }
  let(:current_user) { user }

  before do
    sign_in user
  end
end
