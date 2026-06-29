ActiveAdmin.register Registration do
  permit_params :status

  # El filtro mágico a la derecha de la pantalla (en la pestaña principal)
  filter :role, as: :select, collection: ["Alumno", "Maestro"], label: "Filtrar por Rol"
  filter :event, label: "Evento"
  filter :status, as: :select, collection: ["Pendiente", "Contactado", "Confirmado", "No asistirá"], label: "Estatus"

  # --- ACCIONES DE LOS BOTONES (Solo cambian el estatus en la base de datos) ---
  
  member_action :marcar_contactado, method: :put do
    resource.update(status: 'Contactado')
    redirect_back(fallback_location: admin_events_path, notice: "Marcado como contactado.")
  end

  member_action :marcar_confirmado, method: :put do
    resource.update(status: 'Confirmado')
    redirect_back(fallback_location: admin_events_path, notice: "Asistencia confirmada.")
  end

  member_action :marcar_cancelado, method: :put do
    resource.update(status: 'No asistirá')
    redirect_back(fallback_location: admin_events_path, notice: "Marcado como cancelado.")
  end
end