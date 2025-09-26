# Categorias específicas para cristãos

christian_income_categories = [
  "Salário",
  "Rendimentos extras",
  "Presentes recebidos",
  "Venda de bens",
  "Investimentos",
  "13º salário",
  "Férias",
  "Restituição"
]

christian_expense_categories = [
  # Contribuições religiosas
  "Dízimo",
  "Ofertas",
  "Missões",
  "Construção da igreja",
  "Eventos da igreja",
  "Retiros espirituais",
  "Literatura cristã",
  "Cursos bíblicos",

  # Despesas pessoais e familiares
  "Alimentação",
  "Moradia",
  "Transporte",
  "Saúde",
  "Educação",
  "Vestuário",
  "Lazer familiar",

  # Serviço e generosidade
  "Ajuda ao próximo",
  "Doações beneficentes",
  "Cestas básicas",
  "Apoio missionário",

  # Desenvolvimento pessoal
  "Livros",
  "Cursos",
  "Conferências",

  # Necessidades básicas
  "Contas de consumo",
  "Internet",
  "Telefone",
  "Manutenção do lar",
  "Seguros",
  "Impostos",

  # Emergências e poupança
  "Emergências",
  "Poupança",
  "Investimentos futuros"
]

puts "Criando categorias cristãs..."

christian_income_categories.each do |category_name|
  Category.find_or_create_by!(name: category_name) do |category|
    puts "Criando categoria de receita: #{category_name}"
  end
end

christian_expense_categories.each do |category_name|
  Category.find_or_create_by!(name: category_name) do |category|
    puts "Criando categoria de despesa: #{category_name}"
  end
end

puts "Categorias cristãs criadas com sucesso!"