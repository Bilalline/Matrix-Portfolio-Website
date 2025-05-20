# Используем легковесный образ nginx
FROM nginx:1.24-alpine

# Устанавливаем необходимые пакеты
RUN apk add --no-cache \
    curl \
    tzdata \
    && rm -rf /var/cache/apk/*

# Создаем директории
RUN mkdir -p /usr/share/nginx/html \
    && mkdir -p /etc/nginx/conf.d

# Копируем файлы сайта
COPY index.html /usr/share/nginx/html/
COPY icon.svg /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Устанавливаем правильные права
RUN chown -R nginx:nginx /usr/share/nginx/html \
    && chmod -R 755 /usr/share/nginx/html \
    && chmod 644 /usr/share/nginx/html/icon.svg

# Устанавливаем временную зону
ENV TZ=Europe/Moscow

# Открываем порт
EXPOSE 8080

# Запускаем nginx
CMD ["nginx", "-g", "daemon off;"]
