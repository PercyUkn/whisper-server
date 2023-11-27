# Use an official Python runtime as a parent image
FROM public.ecr.aws/docker/library/python:3.9.18-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install ffmpeg, git, gcc and other build essentials
RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    gcc \
    build-essential \
    libsndfile1

# Install numpy first to avoid issues with other packages depending on it
RUN pip install numpy

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Define environment variable
#ENV NAME World

# Run app.py when the container launches
#CMD ["python3", "-m", "uvicorn", "main:app", "--reload"]
CMD ["python3", "-m", "uvicorn", "main:app", "--host", "0.0.0.0"]
