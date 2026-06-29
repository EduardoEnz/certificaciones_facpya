ActiveAdmin.register Event do
  permit_params :title, :capacity, :start_date, :end_date, :description

  index do
    selectable_column
    id_column
    column "Título", :title
    column "Cupo Máximo", :capacity
    column "Registrados" do |event|
      event.registrations.count
    end
    column "Inicio de Registro", :start_date
    column "Cierre de Registro", :end_date
    actions
  end

  show title: :title do
    attributes_table do
      row "Título" do |e| e.title end
      row "Descripción" do |e| e.description end
      row "Cupo Máximo" do |e| e.capacity end
      row "Inicio de Registro" do |e| e.start_date end
      row "Cierre de Registro" do |e| e.end_date end
      row "Total de Registrados" do |e| e.registrations.count end
    end

    panel "Personas Registradas" do
      if event.registrations.any?
        table_for event.registrations.order(created_at: :desc) do
          column "Rol", :role
          column "Nombre", :name
          column "Correo Electrónico", :email
          column "Celular", :phone
          column "Matrícula", :matricula
          column "Carrera", :career
          column "UANL", :is_uanl
            column "Facultad", :faculty
          
          column "Estatus" do |reg|
            status_tag(reg.status || "Pendiente")
          end
          
          column "Acciones Rápidas" do |reg|
            div style: "display: flex; gap: 5px;" do
              # Botón para Contactado
              span do
                button_to "Contactado", marcar_contactado_admin_registration_path(reg), method: :put, class: "button"
              end
              # Botón para Confirmó
              span do
                button_to "Confirmó", marcar_confirmado_admin_registration_path(reg), method: :put, class: "button"
              end
              # Botón para No asistirá
              span do
                button_to "No asistirá", marcar_cancelado_admin_registration_path(reg), method: :put, class: "button"
              end
            end
          end

          column "Fecha de Registro" do |reg|
            reg.created_at.strftime("%d/%m/%Y %H:%M")
          end
        end
      else
        div class: "blank_slate_container" do
          span class: "blank_slate" do
            "Aún no hay personas registradas en este evento."
          end
        end
      end
    end
  end

  form do |f|
    f.inputs "Detalles de la Conferencia" do
      f.input :title, label: "Título de la Conferencia"
      f.input :description, as: :text, label: "Descripción / Detalles para el usuario"
      f.input :capacity, label: "Cupo de Personas"
      f.input :start_date, as: :datetime_picker, label: "Fecha y Hora de Apertura"
      f.input :end_date, as: :datetime_picker, label: "Fecha y Hora de Cierre"
    end
    f.actions
  end
end