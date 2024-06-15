# Use the official PHP image
FROM php:7.4-apache

# Install necessary PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install additional dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    unzip \
    wget

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set up the working directory
WORKDIR /var/www/html

# Download and install BriskLimbs
RUN wget https://github.com/briskLimbs/briskLimbs/archive/v2.0.1-stable.zip && \
    unzip v2.0.1-stable.zip && \
    mv briskLimbs-2.0.1-stable/* . && \
    rm -rf briskLimbs-2.0.1-stable v2.0.1-stable.zip

# Install BriskLimbs dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose port 8080 for Apache
EXPOSE 8080

# Start Apache in foreground
CMD ["apache2-foreground"]
