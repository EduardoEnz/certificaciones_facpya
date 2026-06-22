ActiveAdmin.register Lead do
  permit_params :name, :email, :phone, :career, :status, :notes

  # --- 1. Desactivamos el "destroy" nativo para quitar su botón roto ---
  actions :all, except: [:destroy]

  # --- 2. Creamos nuestra propia ruta y lógica para eliminar de forma segura ---
  member_action :eliminar, method: :delete do
    resource.destroy
    redirect_to admin_leads_path, status: :see_other, notice: "El prospecto fue eliminado correctamente."
  end

  # --- 3. Nuestro botón personalizado de Eliminar ---
  action_item :eliminar, only: :show do
    button_to 'Eliminar Lead', eliminar_admin_lead_path(resource),
              method: :delete,
              form: { data: { turbo_confirm: '¿Estás seguro de que deseas eliminar este prospecto?' } },
              class: "button"
  end

  # --- 4. Botón y lógica de Contactar (Se mantiene igual) ---
  action_item :contactar, only: :show do
    if resource.status != 'contactado'
      button_to 'Marcar como Contactado', contactar_admin_lead_path(resource), method: :put, class: "button"
    end
  end

  member_action :contactar, method: :put do
    resource.update(status: 'contactado')
    redirect_to resource_path, notice: "El estatus del prospecto se actualizó a Contactado."
  end

  # --- Vistas (index, filter, form, show) ---
  index do
    selectable_column
    column :name
    column :email
    column :phone
    column :career
    column "Estatus" do |lead|
      status_tag lead.status || 'pendiente', class: (lead.status == 'contactado' ? 'ok' : 'warning')
    end
    column :created_at
    actions
  end

  filter :name_cont, label: "Nombre del prospecto"
  filter :email_cont, label: "Correo electrónico"
  filter :status, label: "Estatus", as: :select, collection: ['pendiente', 'contactado', 'inscrito']
  filter :created_at, label: "Fecha de registro"

  form do |f|
    f.inputs "Información del Prospecto" do
      f.input :name, label: "Nombre completo"
      f.input :email, label: "Correo electrónico"
      f.input :phone, label: "Teléfono"
      f.input :career, label: "Carrera / Empresa"
      f.input :status, as: :select, collection: ['pendiente', 'contactado', 'inscrito'], include_blank: false, label: "Estatus del trámite"
      f.input :notes, label: "Notas adicionales"
    end
    f.actions
  end

  show title: proc { |lead| lead.name } do
    attributes_table title: "Detalles del Prospecto" do
      row("Nombre Completo") { |lead| lead.name }
      row("Correo Electrónico") { |lead| lead.email }
      row("Teléfono") { |lead| lead.phone }
      row("Carrera / Empresa") { |lead| lead.career }
      
      row("Estatus") do |lead|
        status_tag lead.status || 'pendiente', class: (lead.status == 'contactado' ? 'ok' : (lead.status == 'inscrito' ? 'yes' : 'warning'))
      end
      
      row("Notas Adicionales") { |lead| lead.notes }
      row("Fecha de Registro") { |lead| lead.created_at.strftime("%d de %B, %Y a las %H:%M") }
      row("Certificaciones de Interés") do |lead| 
        if lead.certifications.any?
          lead.certifications.map(&:title).join(", ")
        else
          "Ninguna seleccionada"
        end
      end
    end
  end
end