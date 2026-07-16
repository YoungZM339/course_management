# Course Management

A Spring Boot 3 application for experimenting with course-management workflows and persistence.

## Technology stack

- Java 17
- Spring Boot 3.3
- Spring Web
- Spring Data JPA and JDBC
- MySQL

## Quick start

Prerequisites: JDK 17, Maven 3.9+, and a running MySQL instance.

~~~bash
mvn spring-boot:run
~~~

Configure database connection properties through the application configuration or environment-specific configuration before starting the application. Never commit database passwords.

For a packaged build:

~~~bash
mvn clean package
java -jar target/*.jar
~~~

## Project notes

The repository is a learning and experimental project. API details and the data model should be treated as implementation-specific until they are covered by tests and documented examples.

## Contributing

Keep changes small, add tests for new endpoints or persistence behavior, and document any schema changes.