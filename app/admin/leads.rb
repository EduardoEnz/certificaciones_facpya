ActiveAdmin.register Lead do
  permit_params :name, :email, :phone, :career, :status, :notes

  # Botones personalizados en la vista de detalle
  action_item :contactar, only: :show do
    if resource.status != 'contactado'
      button_to 'Marcar como Contactado', contactar_admin_lead_path(resource), method: :put, class: "button"
    end
  end

  # Lógica del botón 
  member_action :contactar, method: :put do
    resource.update(status: 'contactado')
    redirect_to resource_path, notice: "El estatus del prospecto se actualizó a Contactado."
  end

  form do |f|
    f.inputs "Información del Prospecto" do
      f.input :name, label: "Nombre completo"
      f.input :email, label: "Correo electrónico"
      f.input :phone, label: "Teléfono"
      f.input :career, label: "Carrera / Empresa"
      
      # Esta es la línea mágica para la lista desplegable
      f.input :status, as: :select, collection: ['pendiente', 'contactado', 'inscrito'], include_blank: false, label: "Estatus del trámite"
      
      f.input :notes, label: "Notas adicionales"
    end
    f.actions
  end

  index do
    selectable_column
    column :name
    column :email
    column :phone
    column :career
    # Etiqueta visual para el estatus
    column "Estatus" do |lead|
      status_tag lead.status || 'Pendiente', class: (lead.status == 'Contactado' ? 'ok' : 'warning')
    end
    column :created_at
    actions
  end

  filter :name_cont, label: "Nombre del prospecto"
  filter :email_cont, label: "Correo electrónico"
  filter :status, label: "Estatus", as: :select, collection: ['pendiente', 'contactado', 'inscrito']
  filter :created_at, label: "Fecha de registro"
  
  show do
    attributes_table do
      row :name
      row :email
      row :phone
      row :career
      row "Estatus" do |lead|
        status_tag lead.status || 'Pendiente', class: (lead.status == 'Contactado' ? 'ok' : 'warning')
      end
      row :notes
      row :created_at
      row(:certificaciones) { |l| l.certifications.map(&:title).join(", ") }
    end
  end
end