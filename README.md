# ComfortConfy - Video Call and Video Conferencing Application

## Project Description

The project is a mobile application for video conferencing, providing duplex mode for real-time video information exchange. The application uses a client-server architecture and allows users to communicate remotely, conduct classes, and organize discussions without gathering people in one place.

## Key Features

- **Registration and Authentication**: Users can create an account and log in from any device.
- **Personal Profile**: Configuration and editing of personal information.
- **Audio and Video Calls**: Making calls with other users.
- **Creation and Configuration of Video Conferences**: Organizing conferences with the ability to set parameters.
- **Participant Roles**:
  - **Administrator**: Full control over the conference.
  - **Moderator**: Assistant to the administrator with limited rights.
  - **Participant**: Conference participant with rights set by the administrator.
- **Technical Support**: Ability to ask questions and get help.

## Technology Stack

- **Main app**: Flutter.
- **Database**:
  - **Main**: PostgreSQL.
  - **Notifications & cloud**: Firebase.
- **Object-Relational Mapping**: Python + SQLAlchemy.
- **RPC-server**: Go.

## Architecture

The application uses a client-server architecture, where the client side is represented by a mobile application, and the server side includes:
- **RPC-server**: Ensures interaction between the client and the server.
- **Database**: Stores user data, information about conferences, and application operation logs.

## Security

Data transmission is carried out using secure network protocols and software settings, ensuring the security and confidentiality of user information.

## Installation

The application will be available for installation on [GitHub](https://github.com) and [RuStore](https://rustore.ru), as well as within the digital educational platform "ДУМА".

## Documentation

- **Technical Specification**: Detailed information on the requirements for system operation and security (Appendix A).
- **User Manual**: Information on the functional capabilities of users (Appendix B).
- **Use Case Diagrams**: Information on the interaction of users and administrators with the system (Appendix C).

## License

This project is licensed under the [MIT License](MIT_LICENSE).
