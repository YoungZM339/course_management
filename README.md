# Course Management

A course-management example system composed of a Spring Boot backend and an Electron/Vue 3 desktop client. It provides management and query screens around courses, teachers, and teaching assignments.

## Implemented Scope

- Create, read, update, and delete course information.
- Create, read, update, and delete teacher information.
- Assign courses to teachers and reject invalid assignment requests.
- Desktop screens for course management, teacher management, course search/statistics, and teaching assignments.
- ECharts visualizations for query or statistical results.

## Architecture

- Backend: Java 17, Spring Boot 3.3, Spring Web, Spring Data JPA, and MySQL.
- Desktop client: Electron, Vue 3, Element Plus, Pinia, axios, and ECharts.
- Backend source: `src/main/java`.
- Desktop source: `src/frontend`.

## Prerequisites

1. Install Java 17, MySQL, and Node.js.
2. Create a MySQL database for local development only.
3. Configure the backend datasource to use your own local database credentials.
4. Do not use or retain development credentials committed to the repository.

## Start the Backend

From the repository root:

    .\mvnw.cmd spring-boot:run

The configured development server port is 9090. Once started, inspect the controller mappings for course, teacher, and assignment endpoints.

## Start the Desktop Client

In another terminal:

    cd src/frontend
    npm install
    npm run dev

The Electron development window connects to the running backend. For packaging, use the `build`, `build:win`, `build:mac`, or `build:linux` scripts defined in `package.json`.

## Development Notes

The backend and desktop client maintain dependencies separately. After changing API URLs, CORS policy, or database fields, review:

- Backend controllers, entities, and database migrations;
- API calls under `src/frontend`;
- Interaction and error handling in the course, teacher, and assignment screens.

## Security and Deployment

This repository is a course-management application example and should not be deployed directly as a production academic administration system. At minimum, production deployment requires:

- Moving database settings, secrets, and service URLs into environment configuration;
- Restricting allowed CORS origins;
- Adding authentication, authorization, and audit policies;
- Validating data before importing or migrating real records.

## License

The repository currently has no declared license.