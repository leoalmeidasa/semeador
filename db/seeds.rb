# Criar categorias
Category.find_or_create_by([
                             { name: "Dízimo" },
                             { name: "Oferta" },
                             { name: "Missões" },
                             { name: "Alimentação" },
                             { name: "Moradia" },
                             { name: "Educação" },
                             { name: "Lazer" }
                           ])
