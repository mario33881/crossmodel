# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

# Want to help us make this template better? Share your feedback here: https://forms.gle/ybq9Krt8jtBL3iCk7

ARG NODE_VERSION=20.13.1

################################################################################
# Use node image for base image for all stages.
FROM node:${NODE_VERSION}-bookworm-slim as base

# Set working directory for all build stages.
WORKDIR /usr/src/app


################################################################################

FROM base as deps

COPY . .

# install dependencies
RUN apt update && apt install -y python3 make build-essential pkgconf libx11-dev libxkbfile-dev libsecret-1-dev

RUN THEIA_ELECTRON_SKIP_REPLACE_FFMPEG=1 yarn

# Expose the port that the application listens on.
EXPOSE 3000

# Run the application.
CMD yarn start:browser --hostname 0.0.0.0
