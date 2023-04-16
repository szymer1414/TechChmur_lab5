# Etap pierwszy - budowa aplikacji webowej
FROM node:14-alpine AS builder

# Ustalamy wersję aplikacji poprzez zmienną ARG
ARG VERSION

# Ustawiamy katalog roboczy
WORKDIR /app

# Kopiujemy pliki aplikacji do katalogu roboczego
COPY . .

# Instalujemy zależności i budujemy aplikację
RUN npm ci && npm run build

# Etap drugi - konfiguracja Nginx
FROM nginx:1.21-alpine

# Kopiujemy pliki z etapu pierwszego do katalogu roboczego Nginx
COPY --from=builder /app/build /usr/share/nginx/html

# Kopiujemy plik konfiguracyjny Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Ustawiamy polecenie HEALTHCHECK
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -qO- http://localhost || exit 1

# Ustawiamy etykietę z informacją o wersji aplikacji
LABEL version=$VERSION

# Uruchamiamy serwer Nginx w trybie daemon
CMD ["nginx", "-g", "daemon off;"]
