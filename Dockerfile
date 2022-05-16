# Build Stage
FROM ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang

## Add source code to the build stage.
ADD . /lexbor
WORKDIR /lexbor

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN mkdir build
WORKDIR build
RUN CC=clang CXX=clang++ cmake .. -DLEXBOR_BUILD_EXAMPLES=ON
RUN make

# Package Stage
FROM ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /lexbor/build/examples/lexbor/html/element_create /
