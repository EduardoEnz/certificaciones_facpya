class ApplicationController < ActionController::Base
  before_action :set_modal_lead

  private

  def set_modal_lead
    @modal_lead = Lead.new
  end
end