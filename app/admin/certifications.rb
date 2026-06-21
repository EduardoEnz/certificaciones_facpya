ActiveAdmin.register Certification do
  permit_params :title, :category, :description, :duration,
                :modality, :price, :start_date, :status,
                :syllabus, :seats_available

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

  filter :title
  filter :category
  filter :status

  form do |f|
    f.inputs "Información General" do
      f.input :title
      f.input :category, as: :select,
              collection: ["Tecnología", "Gestión", "Marketing"]
      f.input :description
      f.input :syllabus, hint: "Una línea por tema del temario"
    end
    f.inputs "Logística" do
      f.input :duration
      f.input :modality, as: :select,
              collection: ["Presencial", "En línea", "Híbrido"]
      f.input :price
      f.input :start_date, as: :datepicker
      f.input :seats_available
      f.input :status
    end
    f.actions
  end
end