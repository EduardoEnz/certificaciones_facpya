class CertificationsController < ApplicationController
  def index
    @certifications = Certification.active
    @certifications = @certifications.by_category(params[:category])
    @categories = Certification.active.distinct.pluck(:category).compact
  end

  def show
    @certification = Certification.find_by!(slug: params[:id])
  end
end