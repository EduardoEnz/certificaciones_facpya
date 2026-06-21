class LeadMailer < ApplicationMailer
  default from: 'notificaciones@certificacionesfacpya.com'

  def new_lead_notification(lead)
    @lead = lead
    mail(
      to: @lead.email, 
      subject: '¡Gracias por tu interés en FACPYA!'
    )
  end
end