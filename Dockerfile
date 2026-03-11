FROM --platform=$BUILDPLATFORM cgr.dev/chainguard/bash@sha256:c0f5407e787dc7676e82443504ca71f371f267a421c96b212291fa1d52cc0d9e AS fetcher

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

# renovate: datasource=github-releases depName=bazelbuild/buildtools
ARG BUILDTOOLS_VERSION=8.5.1

RUN mkdir /out
RUN curl -L -o /out/buildifier https://github.com/bazelbuild/buildtools/releases/download/v$BUILDTOOLS_VERSION/buildifier-$TARGETOS-$TARGETARCH
RUN curl -L -o /out/buildozer https://github.com/bazelbuild/buildtools/releases/download/v$BUILDTOOLS_VERSION/buildozer-$TARGETOS-$TARGETARCH
RUN curl -L -o /out/unused_deps https://github.com/bazelbuild/buildtools/releases/download/v$BUILDTOOLS_VERSION/unused_deps-$TARGETOS-$TARGETARCH

RUN chmod a+x /out/*

FROM cgr.dev/chainguard/bash@sha256:c0f5407e787dc7676e82443504ca71f371f267a421c96b212291fa1d52cc0d9e

COPY --from=fetcher /out/* /usr/local/bin/
ENTRYPOINT []
CMD ["bash", "-i"]
