# Dockerfile for CryptPad Development
FROM node:18-alpine

# Set working directory
WORKDIR /cryptpad

# Install git (needed for cloning dependencies)
RUN apk add --no-cache git

# Clone CryptPad repository
RUN git clone https://github.com/cryptpad/cryptpad.git . && \
    git checkout 2025.3.0

# Install dependencies
RUN npm install && \
    npm run install:components

# Create data directories with proper permissions
RUN mkdir -p blob block data datastore && \
    chown -R node:node /cryptpad

# Switch to non-root user
USER node

# Expose port
EXPOSE 3000

# Start in development mode
CMD ["npm", "run", "dev"]
