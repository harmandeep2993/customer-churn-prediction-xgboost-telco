# Dockerfile

FROM python:3.12-slim

WORKDIR /app

# Install uv
RUN pip install uv

# Copy dependency files
COPY pyproject.toml .
COPY uv.lock .

# Install dependencies
RUN uv sync --frozen

# Copy project files
COPY src/ ./src/
COPY api/ ./api/
COPY models/ ./models/
COPY config.yaml .

# Expose port
EXPOSE 8000

# Run API
CMD ["uv", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]