# Use Node.js LTS
FROM node:20

WORKDIR /app

# Copy backend and frontend package.json files for dependency install
COPY backend/package*.json ./backend/
COPY frontend/package*.json ./frontend/

# Install backend dependencies
RUN cd backend && npm install

# Install frontend dependencies
RUN cd frontend && npm install

# Now copy the rest of the project (including index.html)
COPY . .

# Build frontend after files are copied
RUN cd frontend && npm run build

# Set environment variables
ENV PORT=8080
ENV NODE_ENV=production

EXPOSE 8080

CMD ["node", "backend/server.js"]
