ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  actions :all, except: [:destroy]

  member_action :eliminar, method: :delete do
    # Evitar que el administrador se borre a sí mismo por accidente
    if current_admin_user == resource
      redirect_to admin_admin_user_path(resource), alert: "No puedes eliminar tu propia cuenta mientras estás en sesión."
    else
      resource.destroy
      redirect_to admin_admin_users_path, status: :see_other, notice: "El administrador fue eliminado correctamente."
    end
  end

  action_item :eliminar, only: :show do
    if current_admin_user != resource
      button_to 'Eliminar Administrador', eliminar_admin_admin_user_path(resource),
                method: :delete,
                form: { data: { turbo_confirm: '¿Estás seguro de que deseas eliminar a este administrador del sistema?' } },
                class: "button"
    end
  end

  # --- Vistas (index, filter, form, show) ---
  index title: "Administradores" do
    selectable_column
    id_column
    column :email
    column "Fecha de creación", :created_at
    actions
  end

  filter :email, label: "Correo electrónico"
  filter :created_at, label: "Fecha de creación"

  form title: "Detalles del Administrador" do |f|
    f.inputs do
      f.input :email
      f.input :password, label: "Contraseña"
      f.input :password_confirmation, label: "Confirmar contraseña"
    end
    f.actions
  end

  show title: proc { |admin| admin.email } do
    attributes_table title: "Detalles del Administrador" do
      row("Correo Electrónico") { |admin| admin.email }
      row("Fecha de Creación") { |admin| admin.created_at.strftime("%d de %B, %Y a las %H:%M") }
      row("Última Actualización") { |admin| admin.updated_at.strftime("%d de %B, %Y a las %H:%M") }
    end
  end
end