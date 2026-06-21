ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Últimos Prospectos Registrados" do
          table_for Lead.order("created_at desc").limit(5) do
            column("Nombre") { |lead| link_to lead.name, admin_lead_path(lead) }
            column("Correo", :email)
            column("Estatus") do |lead|
              status_tag lead.status || 'Pendiente', class: (lead.status == 'contactado' ? 'ok' : (lead.status == 'inscrito' ? 'yes' : 'warning'))
            end
            column("Fecha") { |lead| lead.created_at.strftime("%d/%m/%Y") }
          end
        end
      end

      column do
        panel "Resumen del Sistema" do
          ul do
            li "Total de Prospectos: #{Lead.count}"
            li "Prospectos Pendientes: #{Lead.where(status: ['pendiente', nil]).count}"
            li "Certificaciones Activas: #{Certification.where(status: true).count}"
          end
        end
      end
    end
  end
end