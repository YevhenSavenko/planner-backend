# Planner Pro API

**Project Description:**
Planner Pro API is designed solely for API functionality, with all graphical elements disabled. This project provides robust backend support for managing event planning tasks and schedules via a set of well-defined API endpoints.

## Getting Started

Follow these steps to set up the project.

### Prerequisites

- Docker
- Docker Compose

### Setup

1. **Clone the repository:**

    ```bash
    git clone ...
    ```

2. **Copy configuration files:**

    ```bash
    cp docker-compose.yaml.dist docker-compose.yaml
    cp .env.example .env
    ```

3. **Configure environment variables:**

   Open the `.env` file and set the necessary environment variables:

    ```env
    APP_NAME="Planner Pro API"
    APP_ENV=local
    APP_KEY=
    APP_DEBUG=false

    DOCKER_USER_ID=501
    DOCKER_GROUP_ID=1000

    DOCKER_NGINX_EXTERNAL_HOST=127.0.0.1:80

    DOCKER_XDEBUG_CLIENT_HOST=host.docker.internal
    DOCKER_XDEBUG_CLIENT_PORT=9025

    DB_CONNECTION=mysql
    DB_HOST=db
    DB_PORT=3306
    DB_DATABASE=planner
    DB_USERNAME=mysql_user
    DB_PASSWORD=mysql_password
    ```

   Ensure the following variables are set in the `docker-compose.yaml` file:

    ```yaml
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_USER: mysql_user
      MYSQL_PASSWORD: mysql_password
    ```

4. **Set permissions for storage and cache:**

    ```bash
    chmod -R 775 storage bootstrap/cache
    ```

5. **Build and run the containers:**

    ```bash
    docker-compose up --build -d
    ```

6. **Install PHP dependencies:**

    ```bash
    docker-compose exec php composer install
    ```

7. **Run migrations:**

    ```bash
    docker-compose exec php php artisan migrate
    ```

### Testing the API

After setting up the project, you can verify the API is working by making a request to `/api/hello-planner`. If it returns a result, everything is set up correctly.
