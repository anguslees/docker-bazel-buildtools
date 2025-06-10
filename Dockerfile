FROM --platform=$BUILDPLATFORM cgr.dev/chainguard/bash@sha256:64e798e5a114ceb00d917bbec88c4cb7f600ad55b7680aaac0971297b43be909 AS fetcher

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

# renovate: datasource=github-releases depName=bazelbuild/buildtools
ARG BUILDTOOLS_VERSION=8.2.1

RUN mkdir /out
RUN curl -L -o /out/buildifier https://github.com/bazelbuild/buildtools/releases/download/v$BUILDTOOLS_VERSION/buildifier-$TARGETOS-$TARGETARCH
RUN curl -L -o /out/buildozer https://github.com/bazelbuild/buildtools/releases/download/v$BUILDTOOLS_VERSION/buildozer-$TARGETOS-$TARGETARCH
RUN curl -L -o /out/unused_deps https://github.com/bazelbuild/buildtools/releases/download/v$BUILDTOOLS_VERSION/unused_deps-$TARGETOS-$TARGETARCH

RUN chmod a+x /out/*

FROM cgr.dev/chainguard/bash@sha256:64e798e5a114ceb00d917bbec88c4cb7f600ad55b7680aaac0971297b43be909

COPY --from=fetcher /out/* /usr/local/bin/
ENTRYPOINT []
CMD ["bash", "-i"]
