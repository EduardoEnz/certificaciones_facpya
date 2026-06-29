class RegistrationsController < ApplicationController
  def create
    @registration = Registration.new(registration_params)

    if @registration.save
      # Guardamos el registro con éxito y mandamos el mensaje solicitado
      flash[:notice] = "Registro exitoso. Nosotros te contactamos, ESTE REGISTRO NO ASEGURA TU ENTRADA."
      redirect_to events_path
    else
      # Si algo salió mal (ej. falta un campo), mandamos error
      flash[:alert] = "Hubo un error en tu registro: #{@registration.errors.full_messages.join(', ')}"
      redirect_to events_path
    end
  end

  private

  # Definimos qué información aceptamos para mayor seguridad
  def registration_params
    params.permit(:event_id, :role, :name, :email, :phone, :matricula, :career, :is_uanl, :faculty)
  end
end