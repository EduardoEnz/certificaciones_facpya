class LeadsController < ApplicationController
  def new
    @lead = Lead.new
    @certifications = Certification.active
  end

  def create
    @lead = Lead.new(lead_params)

    if @lead.save
      if params[:certification_id].present?
        cert = Certification.find(params[:certification_id])
        @lead.enrollments.create!(certification: cert, status: "pending")
      end
      LeadMailer.new_lead_notification(@lead).deliver_now

      redirect_to root_path, notice: "¡Registro exitoso! Te contactaremos pronto."
    else
      @certifications = Certification.active
      render :new, status: :unprocessable_entity
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:name, :email, :phone, :career, :student_id, :notes)
  end
end