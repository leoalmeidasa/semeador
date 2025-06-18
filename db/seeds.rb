user = User.first || User.create!(email: "admin@semeador.com", password: "123456")

# Resetar dados
Transaction.where(user: user).delete_all
Category.where(user: user).delete_all

# Criar categorias cristãs
categories = Category.create!([
                                { name: "Dízimo", user: user },
                                { name: "Oferta", user: user },
                                { name: "Missões", user: user },
                                { name: "Moradia", user: user },
                                { name: "Alimentação", user: user },
                                { name: "Educação", user: user },
                                { name: "Lazer", user: user },
                                { name: "Salário", user: user }
                              ])

# Util para pegar por nome depois
category_map = categories.index_by(&:name)

# Criar transações variadas
Transaction.create!([
                      { title: "Salário - Junho", amount: 5000, transaction_type: "income", date: Date.today - 10, user: user, category: category_map["Salário"] },
                      { title: "Dízimo de Junho", amount: 500, transaction_type: "expense", date: Date.today - 9, user: user, category: category_map["Dízimo"] },
                      { title: "Oferta especial", amount: 100, transaction_type: "expense", date: Date.today - 8, user: user, category: category_map["Oferta"] },
                      { title: "Supermercado", amount: 350, transaction_type: "expense", date: Date.today - 7, user: user, category: category_map["Alimentação"] },
                      { title: "Aluguel", amount: 1200, transaction_type: "expense", date: Date.today - 6, user: user, category: category_map["Moradia"] },
                      { title: "Curso bíblico online", amount: 200, transaction_type: "expense", date: Date.today - 5, user: user, category: category_map["Educação"] },
                      { title: "Viagem para congresso", amount: 300, transaction_type: "expense", date: Date.today - 4, user: user, category: category_map["Missões"] },
                      { title: "Café com amigos", amount: 50, transaction_type: "expense", date: Date.today - 2, user: user, category: category_map["Lazer"] },
                      { title: "Salário - Maio", amount: 5000, transaction_type: "income", date: Date.today - 35, user: user, category: category_map["Salário"] },
                      { title: "Dízimo de Maio", amount: 500, transaction_type: "expense", date: Date.today - 30, user: user, category: category_map["Dízimo"] }
                    ])
