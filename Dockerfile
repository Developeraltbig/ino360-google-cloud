# Use Node.js LTS
FROM node:20

# Set working directory
WORKDIR /app

# Copy package.json files first (dependency caching)
# Use ./ to copy into the current WORKDIR context for clarity
COPY backend/package*.json ./backend/
COPY frontend/package*.json ./frontend/

# Install backend dependencies
# Use --only=production for smaller image size and better security
RUN cd backend && npm install --only=production

# Install frontend dependencies
RUN cd frontend && npm install

# Copy the rest of the project
COPY . .

# Build the frontend
WORKDIR /app/frontend
RUN npm run build

# Switch back to root app folder
WORKDIR /app

# Set Node environment to production
ENV NODE_ENV=production

# Start backend server (it will serve the frontend build)
CMD ["node", "backend/server.js"]