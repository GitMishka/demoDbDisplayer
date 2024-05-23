FROM python:3.9-slim

WORKDIR /app

# Install system dependencies required by psycopg2 and other packages
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# Copy and install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . /app

# Make port 5000 available to the world outside this container.
EXPOSE 5000

# Define environment variable for Flask to run in production.
ENV FLASK_ENV=production

# Command to run the Flask app using the built-in server.
CMD ["flask", "run", "--host=0.0.0.0"]
