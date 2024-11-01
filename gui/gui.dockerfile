# Dockerfile for the React app
FROM node:latest AS build

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Set up build argument and environment variable for the React app API URL
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

# Debugging: Print the value of the environment variable
RUN echo "REACT_APP_API_URL is set to $REACT_APP_API_URL"

# Copy the rest of the application code
COPY / ./

# Build the React app
RUN npm run build

# Use a lightweight server to serve the app
FROM node:alpine

WORKDIR /app

# Copy the build artifacts from the previous stage
COPY --from=build /app/build ./build

# Install serve to serve the app
RUN npm install -g serve

# Expose the port the app runs on
EXPOSE 80

# Command to run the app
CMD ["serve", "-s", "build", "-l", "3000"]