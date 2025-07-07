# Use official PHP with Apache
FROM php:8.1-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy existing application directory contents
COPY . /var/www/html

# Install PHP dependencies (if you have composer.json)
RUN if [ -f composer.json ]; then composer install --no-dev --optimize-autoloader; fi

# Create necessary directories and set permissions
RUN mkdir -p /var/www/html/api/tmp \
    && mkdir -p /var/www/html/tmp \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 777 /var/www/html/api/tmp \
    && chmod -R 777 /var/www/html/tmp

# Copy Apache configuration (optional - for custom vhost)
# COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]