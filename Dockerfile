FROM --platform=$BUILDPLATFORM cgr.dev/chainguard/bash@sha256:70e350e214d6b436d5c9ef6ab5fa12f246a5c5315ae87a7c0f502b703ff766f2 AS fetcher

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

FROM cgr.dev/chainguard/bash@sha256:70e350e214d6b436d5c9ef6ab5fa12f246a5c5315ae87a7c0f502b703ff766f2

COPY --from=fetcher /out/* /usr/local/bin/
ENTRYPOINT []
CMD ["bash", "-i"]
