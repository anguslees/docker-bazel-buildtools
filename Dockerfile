FROM --platform=$BUILDPLATFORM cgr.dev/chainguard/bash@sha256:f2a3b88dc4d149d2c468dfd57f6ac562cc178aee0ad18d277477a460586366fe AS fetcher

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

FROM cgr.dev/chainguard/bash@sha256:f2a3b88dc4d149d2c468dfd57f6ac562cc178aee0ad18d277477a460586366fe

COPY --from=fetcher /out/* /usr/local/bin/
ENTRYPOINT []
CMD ["bash", "-i"]
