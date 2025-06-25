<h1 align="center">🏠 Future Home </h1>

![Purple and Pink Gradient Modern Bold Mobile App Presentation](https://github.com/user-attachments/assets/5862960f-321d-4512-86f4-f1ba617d1d4a)

Future Home é um aplicativo desenvolvido com Flutter, com o objetivo de ajudar usuários a avaliar residências antes da compra. A proposta é permitir comparações entre avaliações feitas, facilitando a escolha do imóvel ideal.

## :page_facing_up: Explicação

A tela inicial exibe todas as avaliações realizadas pelo usuário, com opção de criar uma nova. Ao tocar em um cartão, você acessa a página de detalhes da avaliação, onde é possível visualizar todas as informações registradas, editar entradas ou excluir.  


## 📸 Capturas de Tela
<table>
  <tr>
    <td><img width="300" src="https://github.com/user-attachments/assets/bb4dfbd3-dc98-4bd2-9203-fcbb3326b2cf" /></td>
    <td><img width="300" src="https://github.com/user-attachments/assets/ce8d0674-9f83-4dba-be81-a1c6bc5a02cb" /></td>
    <td><img width="300" src="https://github.com/user-attachments/assets/c6b5b61f-b8c9-418a-a1c6-d37fec46d171" /></td>
  <tr>
    <td><img width="300" src="https://github.com/user-attachments/assets/4d359234-c68b-46cf-8169-cb3cea57a961" /></td>
    <td><img src="https://github.com/user-attachments/assets/a00e7c91-da29-4572-a6af-764f17da577a" width="300"/></td>
    <td><img src="https://github.com/user-attachments/assets/19482219-da05-4497-9144-427ab1db6981" width="300"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/0ffc2873-1569-4016-8e5e-31948c408014" width="300"/></td>
    <td><img src="https://github.com/user-attachments/assets/bad18ab2-1350-46c2-95b1-0cdfb1541fc6" width="300"/></td>
    <td><img src="https://github.com/user-attachments/assets/ad120e54-4603-49d6-9ba9-12f9d4d3d05c" width="300"/></td>
  </tr>
</table>

## 📁 Telas

O APP é composto por 6 telas diferentes:

- **Login:** Tela inicial para acesso ao app. O usuário informa seu e-mail e senha para entrar em sua conta e visualizar suas avaliações.
- **Cadastro:** Permite que novos usuários criem uma conta, preenchendo informações como nome, e-mail e senha para começar a usar o aplicativo.
- **Listagem de Avaliações:** Exibe todos os laudos cadastrados pelo usuário, com resumo das principais informações.
- **Criar Avaliação:** Formulário para inserir dados do imóvel: localização, características, notas e ect..
- **Detalhes da Avaliação:** Apresenta todas as informações registradas, com botões para editar ou excluir o laudo.
- **Editar Avaliação:** Mesma interface de criação, mas pré-preenchida com os dados existentes para ajustes rápidos.

## :dart: Funcionalidades Implementadas

:heavy_check_mark: Listagem dinâmica de avaliações;\
:heavy_check_mark: Componentes reutilizáveis e estilização personalizada;\
:heavy_check_mark: AppBar customizada para todas as telas;\
:heavy_check_mark: Formulário de cadastro de avaliação residencial;\
:heavy_check_mark: Página de detalhes com opções de edição e exclusão;\
:heavy_check_mark: Lógica de criação, leitura, atualização e deleção (CRUD);\
:heavy_check_mark: Geolocalização para capturar automaticamente o endereço do imóvel;\
:heavy_check_mark: Informação sobre a temperatura atual;\
:heavy_check_mark: Login e Cadastro com Firebase;\
:heavy_check_mark: Testes unitários e widgets;

## :rocket: Tecnologias

As seguintes ferramentas foram utilizadas neste projeto:

- [Dart](https://dart.dev/)
- [Flutter](https://flutter.dev/)
- [sqflite](https://pub.dev/packages/sqflite)
- [provider](https://pub.dev/packages/provider)
- [geolocator](https://pub.dev/packages/geolocator)

## :closed_book: Requisitos ##

Antes de começar, você precisa ter [Git](https://git-scm.com) e [Flutter](https://docs.flutter.dev/get-started/install) instalados em seu computador.

## :package: Configuração do Firebase ##

Siga as instruções da seção [Configuração do Firebase](https://firebase.google.com/docs/auth/flutter/start?hl=pt-br).

Ative o provedor de autenticação desejado no [Firebase Console](https://console.firebase.google.com/u/0/) (ex: Email/Senha).

Para usar o Firebase no projeto, é necessário configurar sua API key usando um arquivo .env.

Crie um arquivo .env na raiz do projeto (no mesmo nível do pubspec.yaml).

Dentro do arquivo .env, adicione sua chave da API do Firebase no seguinte formato:
```bash
API_KEY=Sua_API_KEY_aqui
```

## :checkered_flag: Getting Started ##

```bash
# Clone o projeto
$ git clone https://github.com/VictorBren0/future_home_app.git

# Accesso
$ cd future_home_app

# Instalando dependencias
$ flutter pub get

# Rodando o projeto
$ flutter run

# Abra seu projeto no Emulador ou dispositivo físico
```
