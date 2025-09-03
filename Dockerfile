# ---------- Stage 1: Build React frontend ----------
FROM node:20-alpine AS frontend-build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY public ./public
COPY src ./src

RUN npm run build   # builds frontend -> /app/build

# ---------- Stage 2: Setup backend ----------
FROM node:20-alpine AS backend

WORKDIR /app

# Copy backend package.json and install
COPY backend/package*.json ./backend/
RUN cd backend && npm install

# Copy backend source
COPY backend ./backend

# Copy frontend build into backend (if backend serves frontend)
COPY --from=frontend-build /app/build ./backend/build

WORKDIR /app/backend
EXPOSE 5000
CMD ["node", "index.js"]
