<h1 align="center">🏠 Future Home </h1>

![Purple and Pink Gradient Modern Bold Mobile App Presentation](https://github.com/user-attachments/assets/5862960f-321d-4512-86f4-f1ba617d1d4a)

Future Home é um aplicativo desenvolvido com Flutter, com o objetivo de ajudar usuários a avaliar residências antes da compra. A proposta é permitir comparações entre avaliações feitas, facilitando a escolha do imóvel ideal.

## :page_facing_up: Explicação

A tela inicial exibe todas as avaliações realizadas pelo usuário, com opção de criar uma nova. Ao tocar em um cartão, você acessa a página de detalhes da avaliação, onde é possível visualizar todas as informações registradas, editar entradas ou excluir.  

## 📸 Capturas de Tela

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/169c2610-ac3f-409d-9e47-fba31dd2a31d" width="300"/></td>
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

O APP é composto por 4 telas diferentes:

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
:heavy_check_mark: Geolocalização para capturar automaticamente o endereço do imóvel;

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

Certifique-se de ter o FlutterFire CLI instalado:
```bash
$ dart pub global activate flutterfire_cli
```

Autentique-se com sua conta Google (a mesma usada no Firebase):
```bash
$ flutterfire configure
```
Siga o assistente:

Escolha o projeto Firebase

Selecione as plataformas (Android, iOS, Web, etc.)

Isso criará um arquivo `firebase_options.dart` na pasta `lib/` do seu projeto.

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
