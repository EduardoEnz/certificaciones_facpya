# Crear usuario administrador
AdminUser.find_or_create_by!(email: "admin@facpya.uanl.mx") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
end
puts "✅ Admin creado"

# Crear certificaciones
[
  {
    title: "Power BI", category: "Tecnología",
    duration: "40 horas", modality: "Presencial",
    price: 4500.00, start_date: Date.new(2025, 7, 14),
    status: true, seats_available: 25,
    description: "Domina la visualización de datos y análisis empresarial con Microsoft Power BI. Aprende a crear dashboards profesionales desde cero.",
    syllabus: "Introducción a Power BI Desktop\nConexión a fuentes de datos\nModelado y transformación de datos\nLenguaje DAX avanzado\nDashboards e informes interactivos\nPublicación en Power BI Service"
  },
  {
    title: "Excel Avanzado", category: "Tecnología",
    duration: "30 horas", modality: "Híbrido",
    price: 3200.00, start_date: Date.new(2025, 8, 4),
    status: true, seats_available: 30,
    description: "Lleva tus habilidades de Excel al siguiente nivel con macros, VBA y Power Query. Automatiza procesos y analiza datos de forma profesional.",
    syllabus: "Macros y programación VBA\nPower Query y Power Pivot\nTablas dinámicas avanzadas\nFunciones estadísticas y financieras\nAutomatización de reportes\nGráficos avanzados"
  },
  {
    title: "Scrum Master", category: "Gestión",
    duration: "20 horas", modality: "En línea",
    price: 2800.00, start_date: Date.new(2025, 7, 21),
    status: true, seats_available: 20,
    description: "Certifícate en el framework ágil más demandado del mercado laboral. Aprende a gestionar equipos y proyectos con metodología Scrum.",
    syllabus: "Fundamentos del Framework Scrum\nRoles: PO, Scrum Master, Dev Team\nCeremonias y artefactos Scrum\nProduct Backlog y User Stories\nSprint Planning y Review\nPreparación para certificación PSM I"
  },
  {
    title: "Marketing Digital", category: "Marketing",
    duration: "45 horas", modality: "Híbrido",
    price: 5000.00, start_date: Date.new(2025, 9, 1),
    status: true, seats_available: 25,
    description: "Estrategias digitales para posicionar marcas y generar resultados medibles. Domina SEO, redes sociales y analítica web.",
    syllabus: "SEO y posicionamiento orgánico\nSEM con Google Ads\nGestión de redes sociales\nEmail marketing y automatización\nAnalítica web con Google Analytics\nEstrategia de contenidos"
  }
].each do |attrs|
  Certification.find_or_create_by!(title: attrs[:title]) do |c|
    c.assign_attributes(attrs)
  end
  puts "✅ Certificación: #{attrs[:title]}"
end

puts "\n🎉 Seeds completados!"