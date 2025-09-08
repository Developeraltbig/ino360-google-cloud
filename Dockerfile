# Use Node.js LTS
FROM node:20

# Set working directory
WORKDIR /app

# Copy package.json files
COPY backend/package*.json ./backend/
COPY frontend/package*.json ./frontend/

# Install backend dependencies
RUN cd backend && npm install

# Install frontend dependencies & build
RUN cd frontend && npm install && npm run build

# Copy the rest of the files
COPY . .

# Set environment variables (optional)
ENV PORT=8080
ENV NODE_ENV=production

# Expose port
EXPOSE 8080

# Start server
CMD ["node", "backend/server.js"]
