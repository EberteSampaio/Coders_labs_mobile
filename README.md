# **Helpdesk App**

O **Helpdesk App** é um aplicativo de gerenciamento de suporte técnico, desenvolvido com **Flutter**, que permite o cadastro, listagem e visualização de tickets de problemas ou solicitações de suporte. Ele foi projetado para fornecer uma solução simples e eficaz para a comunicação entre usuários e equipes de suporte.

## Funcionalidades

### 1. Cadastro de Tickets
- Permite ao usuário cadastrar um novo ticket de suporte, fornecendo um título e uma descrição do problema ou solicitação.
- Após o cadastro, o ticket é salvo na lista e o usuário recebe um feedback de sucesso.

### 2. Listagem de Tickets
- Exibe uma lista com todos os tickets cadastrados.
- Cada item na lista mostra o informações do ticket.
- O usuário pode clicar em um ticket para ver os detalhes completos.

### 3. Detalhes do Ticket
- Exibe todas informações do ticket selecionado.
- Ideal para que os usuários acompanhem as informações específicas de cada solicitação ou problema registrado.

### 4. Perfil do Usuário
- Mostra o perfil básico do usuário, com ícone e nome.
- Pode ser expandido para permitir funcionalidades como edição do perfil no futuro.

## Interface do Usuário

O aplicativo utiliza uma barra de navegação inferior com as seguintes abas:
- **Cadastrar Ticket**: Abre a página para cadastrar um novo ticket de suporte.
- **Listar Tickets**: Exibe a lista de tickets cadastrados.
- **Perfil**: Mostra as informações do perfil do usuário.
- **Sobre o App**: Exibe informações sobre o aplicativo e suas políticas.

## Tecnologias Utilizadas
- **Flutter**: Framework para o desenvolvimento de interfaces de aplicativos móveis.
- **Dart**: Linguagem de programação utilizada pelo Flutter.

## Fluxo do Usuário
1. **Cadastrar Ticket**: O usuário pode ir à aba "Cadastrar", preencher o título e a descrição, e registrar o ticket.
2. **Listar Tickets**: Na aba "Listar", o usuário visualiza todos os tickets cadastrados e pode selecionar um ticket para visualizar seus detalhes.
3. **Alterar dados do Tickets**: Ao clicar no ticket, o usuário pode alterar dados e deletar o ticket.
4. **Adicionar Follow-ups**: Usuários podem interagir entre si via follow-up.
5. **Visualizar Perfil**: Na aba "Perfil", o usuário pode visualizar suas informações básicas.

## Como Executar o Projeto

### Pré-requisitos:
- Flutter instalado (versão estável mais recente)
- Dart SDK

### Passos:
1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/helpdesk-app.git
   ```

2. Execute o aplicativo:
   ```bash
   flutter run
   ```
