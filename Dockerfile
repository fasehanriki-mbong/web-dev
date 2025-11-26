# Use official nginx image
FROM nginx:alpine

# Install dependencies and create necessary directories
RUN apk add --no-cache \
    nodejs \
    npm \
    && mkdir -p /usr/share/nginx/html

# Set working directory
WORKDIR /app

# Copy website files
COPY index.html style.css script.js /usr/share/nginx/html/

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create a simple health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

