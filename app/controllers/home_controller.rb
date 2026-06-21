class HomeController < ApplicationController
  def index
    @certifications = Certification.active.limit(4)
  end
end