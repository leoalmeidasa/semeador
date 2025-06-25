# Semeador




## Descrição

O projeto **Semeador** é uma aplicação web desenvolvida em Ruby on Rails, projetada para um sistema de controle de finanças para cristãos, com foco em princípios bíblicos de mordomia financeira. Ele oferece ferramentas para gerenciar dízimos, ofertas, despesas e receitas, ajudando os usuários a praticar a fé em suas finanças.. Ele utiliza PostgreSQL como banco de dados e incorpora diversas tecnologias modernas para oferecer uma experiência robusta e eficiente.




## Tecnologias Utilizadas

O Semeador é construído com as seguintes tecnologias:

*   **Ruby on Rails**: Framework web para desenvolvimento rápido e eficiente.
    *   Versão do Ruby: `3.2.0`
    *   Versão do Rails: `8.0.2`
*   **PostgreSQL**: Banco de dados relacional robusto e de código aberto.
*   **Tailwind CSS**: Framework CSS utilitário para estilização rápida e responsiva.
*   **Turbo Rails**: Para otimização de performance e experiência do usuário.
*   **Jbuilder**: Para construção de APIs JSON.
*   **Bootstrap**: Framework de front-end para componentes de UI.
*   **SassC-Rails**: Para compilação de Sass no Rails.
*   **Chartkick** e **Groupdate**: Para criação de gráficos e visualizações de dados.
*   **Kamal**: Para deploy da aplicação em contêineres Docker.
*   **Devise**: Para autenticação de usuários.




## Como Começar

Para configurar e executar o projeto Semeador localmente, siga os passos abaixo:

### Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas em sua máquina:

*   Ruby (versão 3.2.0 ou superior)
*   Bundler
*   PostgreSQL
*   Node.js e Yarn (para assets do frontend)
*   Docker e Kamal (para deploy, opcional)

### Instalação

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/leoalmeidasa/semeador.git
    cd semeador
    ```

2.  **Instale as dependências do Ruby:**
    ```bash
    bundle install
    ```

3.  **Configure o banco de dados:**
    Crie o arquivo `config/database.yml` com suas credenciais do PostgreSQL. Você pode usar o `config/database.yml.example` como base.
    ```yaml
    # config/database.yml
    default:
      adapter: postgresql
      encoding: unicode
      pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

    development:
      <<: *default
      database: semeador_development
      username: seu_usuario_pg
      password: sua_senha_pg

    test:
      <<: *default
      database: semeador_test
      username: seu_usuario_pg
      password: sua_senha_pg
    ```

4.  **Crie e migre o banco de dados:**
    ```bash
    rails db:create
    rails db:migrate
    ```

5.  **Popule o banco de dados (opcional):**
    ```bash
    rails db:seed
    ```

6.  **Execute o servidor:**
    ```bash
    bin/dev
    ```

    A aplicação estará disponível em `http://localhost:3000`.




## Executando os Testes

Para executar a suíte de testes da aplicação, utilize o seguinte comando:

```bash
rails test
```




## Deploy

O projeto Semeador utiliza [Kamal](https://kamal-deploy.org/) para deploy em contêineres Docker. Para realizar o deploy, siga a documentação oficial do Kamal e configure o arquivo `.kamal/deploy.yml` de acordo com seu ambiente.




## Contribuição

Contribuições são bem-vindas! Se você deseja contribuir com o projeto Semeador, por favor, siga estas diretrizes:

1.  Faça um fork do repositório.
2.  Crie uma nova branch para sua feature (`git checkout -b feature/sua-feature`).
3.  Faça suas alterações e commit (`git commit -m 'Adiciona nova feature'`).
4.  Envie para a branch (`git push origin feature/sua-feature`).
5.  Abra um Pull Request.




## Licença

Este projeto está licenciado sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.




## Autor

Este projeto foi desenvolvido por [leoalmeidasa](https://github.com/leoalmeidasa).


