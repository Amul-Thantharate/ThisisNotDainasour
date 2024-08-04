FROM python:3.13.0rc1-slim

# Set the working directory

WORKDIR /app

# Update and install dependencies

RUN apt-get update && apt-get upgrade -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*


COPY requirements.txt requirements.txt

RUN pip install --upgrade pip

RUN pip3 install --no-cache-dir -r requirements.txt 

RUN pip3 install --no-cache-dir streamlit

# Copy the current directory contents into the container at /app

COPY .env /app/

COPY . /app/

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health 

ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]

