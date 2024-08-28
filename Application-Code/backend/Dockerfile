# Stage 1: Build Stage
FROM node:14 as build

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy only package.json and package-lock.json to leverage Docker's caching mechanism
COPY package*.json ./

# Install project dependencies (including dev dependencies)
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application (if needed)
# RUN npm run build   # Uncomment this line if your project requires a build step

# Stage 2: Production Stage
# Use a lighter, more secure base image for production based on Debian 11 (Bullseye)
FROM node:14-bullseye-slim

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy only the necessary files from the build stage
COPY --from=build /usr/src/app .

# Install production dependencies only
RUN npm install --production

# Expose the application's port
EXPOSE 3500

# Define the command to run the application
CMD ["node", "index.js"]
