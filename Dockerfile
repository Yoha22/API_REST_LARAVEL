FROM php:8.2-cli

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    git unzip curl sqlite3 libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia el código al contenedor
WORKDIR /app
COPY . .

# Crea el archivo de base de datos
RUN mkdir -p /app/database && touch /app/database/database.sqlite

# Copia y configura .env
RUN cp .env.example .env

# Instala dependencias y configura Laravel
RUN composer install --no-dev --optimize-autoloader \
    && php artisan config:clear \
    && php artisan key:generate \
    && php artisan migrate --force \
    && php artisan config:cache

EXPOSE 10000

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=10000"]
