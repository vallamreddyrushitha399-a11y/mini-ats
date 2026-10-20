# One container serves both the API and the built React app (single URL, no CORS setup).

# ---- Stage 1: build the React frontend ----
FROM node:20-alpine AS frontend
WORKDIR /build
COPY frontend/package.json frontend/package-lock.json* ./
RUN npm install
COPY frontend/ ./
RUN npm run build

# ---- Stage 2: Python API + built frontend ----
FROM python:3.12-slim
WORKDIR /app
ENV PYTHONUNBUFFERED=1 \
    STATIC_DIR=/app/static \
    ATS_DB_PATH=/app/data/ats.db
COPY backend/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
COPY backend/app ./app
COPY --from=frontend /build/dist ./static
RUN mkdir -p /app/data
EXPOSE 8000
# Hosting platforms (e.g. Render) provide the port in $PORT.
CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000}"]
