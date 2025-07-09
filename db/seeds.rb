# Criar categorias
Category.find_or_create_by([
                             { name: "Dizimo" },
                             { name: "Oferta" },
                             { name: "Missoes" },
                             { name: "Alimentacao" },
                             { name: "Moradia" },
                             { name: "Educacao" },
                             { name: "Lazer" }
                           ])
