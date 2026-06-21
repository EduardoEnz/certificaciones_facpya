ActiveAdmin.register Certification do
  permit_params :title, :category, :description, :duration,
                :modality, :price, :start_date, :status,
                :syllabus, :seats_available

  controller do
    def find_resource
      scoped_collection.find_by!(slug: params[:id])
    end
  end

  # Vista de la tabla principal
  index do
    selectable_column
    column :title
    column :category
    column :modality
    column :price
    column :start_date
    column(:status) { |c| c.status ? "✅ Activa" : "❌ Inactiva" }
    actions
  end

  # Filtros laterales
  filter :title_cont, label: "Título de la certificación"
  filter :category, label: "Categoría", as: :select, collection: ["Tecnología", "Gestión", "Marketing"]
  filter :status, label: "¿Certificación activa?"

  form do |f|
    f.inputs "Información General" do
      f.input :title, label: "Título de la certificación"
      f.input :category, label: "Categoría", as: :select, collection: ["Tecnología", "Gestión", "Marketing"], include_blank: false
      f.input :description, label: "Descripción detallada", input_html: { rows: 4 }
      f.input :syllabus, label: "Temario", hint: "Escribe una línea por cada tema.", input_html: { rows: 4 }
    end

    f.inputs "Logística y Costos" do
      f.input :duration, label: "Duración (Ej. 40 horas)"
      f.input :modality, label: "Modalidad", as: :select, collection: ["Presencial", "En línea", "Híbrido"], include_blank: false
      f.input :price, label: "Precio de inversión (MXN)"
      f.input :start_date, label: "Fecha de inicio", as: :datepicker
      f.input :seats_available, label: "Cupo total"
      f.input :status, label: "¿Certificación activa?"
    end
    f.actions
  end
end