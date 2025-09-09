# Use Node.js LTS
FROM node:20

# Set working directory
WORKDIR /app

# Copy package.json files first (dependency caching)
COPY backend/package*.json ./backend/
COPY frontend/package*.json ./frontend/

# Install backend dependencies
RUN cd backend && npm install

# Install frontend dependencies
RUN cd frontend && npm install

# Copy the rest of the project (including index.html)
COPY . .

# Build the frontend
WORKDIR /app/frontend
RUN npm run build

# Switch back to root app folder
WORKDIR /app

# Set environment variables
ENV PORT=8080
ENV NODE_ENV=production

# Expose the port
EXPOSE 8080

# Start backend server (must serve frontend build in production)
CMD ["node", "backend/server.js"]
