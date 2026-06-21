ActiveAdmin.register Lead do
  permit_params :name, :email, :phone, :career, :status, :notes

  # Botones personalizados en la vista de detalle
  action_item :contactar, only: :show do
    link_to 'Marcar como Contactado', contactar_admin_lead_path(resource), method: :put if resource.status != 'Contactado'
  end

  # Lógica del botón personalizado
  member_action :contactar, method: :put do
    resource.update(status: 'Contactado')
    redirect_to resource_path, notice: "El estatus del prospecto se actualizó a Contactado."
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

  filter :name
  filter :email
  filter :status

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