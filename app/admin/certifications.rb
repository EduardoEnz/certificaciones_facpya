ActiveAdmin.register Certification do
  permit_params :title, :category, :description, :duration,
                :modality, :price, :start_date, :status,
                :syllabus, :seats_available

  # Permite buscar por la URL amigable en lugar del ID
  controller do
    def find_resource
      scoped_collection.find_by!(slug: params[:id])
    end
  end

  # --- 1. Desactivamos el botón Eliminar nativo ---
  actions :all, except: [:destroy]

  # --- 2. Lógica para eliminar de forma segura ---
  member_action :eliminar, method: :delete do
    resource.destroy
    redirect_to admin_certifications_path, status: :see_other, notice: "La certificación fue eliminada correctamente."
  end

  # --- 3. Nuestro botón personalizado de Eliminar ---
  action_item :eliminar, only: :show do
    button_to 'Eliminar Certificación', eliminar_admin_certification_path(resource),
              method: :delete,
              form: { data: { turbo_confirm: '¿Estás seguro? Si eliminas esta certificación, también se borrará el registro de interés de los prospectos asociados a ella.' } },
              class: "button"
  end

  # --- Vistas de Tabla y Filtros ---
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

  filter :title_cont, label: "Título de la certificación"
  filter :category, label: "Categoría", as: :select, collection: ["Tecnología", "Gestión", "Marketing"]
  filter :status, label: "¿Certificación activa?"

  # --- Formulario de Edición ---
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

  # --- 4. Vista de Detalles (Limpia y en Español) ---
  show title: proc { |cert| cert.title } do
    attributes_table title: "Detalles de la Certificación" do
      row("Título") { |cert| cert.title }
      row("Categoría") { |cert| cert.category }
      row("Descripción") { |cert| cert.description.present? ? cert.description : "VACÍO" }
      row("Temario") { |cert| cert.syllabus.present? ? cert.syllabus : "VACÍO" }
      row("Duración") { |cert| cert.duration }
      row("Modalidad") { |cert| cert.modality }
      row("Precio de Inversión") { |cert| "$#{cert.price} MXN" }
      row("Fecha de Inicio") { |cert| cert.start_date&.strftime("%d de %B de %Y") }
      row("Cupos Totales") { |cert| cert.seats_available }
      row("Estatus") do |cert|
        status_tag cert.status ? 'Activa' : 'Inactiva', class: (cert.status ? 'yes' : 'no')
      end
    end
  end
end