<div style="text-align: center;">
  C O M F O R T C O N F Y

  Мобильное приложение для видеоконференций 

  <img src="assets/logo.svg" alt="Альтернативный текст" style="display: block; margin: auto;">
</div>

<div style="border: 2px solid red; padding: 10px; margin: 20px 0; text-align: center;">
  <strong>IMPORTANT</strong>
  Использование исходного кода приложение разрешено согласно правилам, указанные в лицензии на распространие исходного кода MIT Licence. Backend и связи его с мобильным приложением необходимо написать самостоятельно, т.к. функциональные возможности могут быть иными
</div>

## Функциональные возможности пользователей:

- **Регистрация, авторизация и аутентификация**: Пользователи могут создавать аккаунты в приложении и осущесталять из-под них деятельность в приложении;
- **Персонализация профиля**: Пользователи могут настроить профиль на свое усмотрение;
- **Поиск конференций**: Пользователи могут подключится к видеоконференции из мобильного приложения, введя название конференции или ссылку для подключения;
- **Создание и настройка видеоконференций**: Организация видеоконференции по заданным параметрам;
- **Роли участников**:
  - **Админ/создатель** - осуществляет полный контроль за процессом конференции;
  - **Модератор** - ассистент админа с ограниченным набором прав;
  - **Участник** - имеет базовый набор опций (управление микрофоном, веб-камерой, звуком), а также может быть назначен модератором;
- **Техническая поддержка**: Подсистема для ответов на вопросы пользователей в виде телеграм-бота.

## Технологический стек:

### Mobile:

<table>
  <tr>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
    </td>
    <td align="center" width="150">
       <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
    </td>
  </tr>
</table>

### Backend:

- **ReST Controller**: Базовые CRUD-операции

<table>
  <tr>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python"/>
    </td>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white" alt="FastAPI"/>
    </td>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/SQLAlchemy-000000?style=for-the-badge&logo=sqlalchemy&logoColor=white" alt="SQLAlchemy"/>
    </td>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/Poetry-60A5FA?style=for-the-badge&logo=poetry&logoColor=white" alt="Poetry"/>
    </td>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/Pydantic-306998?style=for-the-badge&logo=pydantic&logoColor=white" alt="Pydantic"/>
    </td>
  </tr>
</table>

- **RPC Controller**: Логика организации и проведения видеоконференций

<table>
  <tr>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white" alt="Go"/>
    </td>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/Streaming(Go)-00ADD8?style=for-the-badge&logo=go&logoColor=white" alt="Streaming (Go)"/>
    </td>
  </tr>
</table>

- **TG-Bot**: Техническая поддержка пользователей

<table>
  <tr>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python"/>
    </td>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/Telebot-blue?style=for-the-badge&logo=telegram&logoColor=white" alt="Telebot"/>
    </td>
  </tr>
</table>

- **Database Management Systems**: СУБД, использованные для хранение объектов бизнес-логики и аналитики 

<table>
  <tr>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL"/>
    </td>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=white" alt="Firebase"/>
    </td>
  </tr>
</table>

- **Others Instruments**: Инструменты контейнеризации образа экземляра СУБД и ПО для администрирования VDS-сервера

<table>
  <tr>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker"/>
    </td>
    <td align="center" width="150">
      <img src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" alt="Ubuntu"/>
    </td>
  </tr>
</table>