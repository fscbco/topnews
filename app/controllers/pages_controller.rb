class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]
end
