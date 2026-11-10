# Official Postiz image + small local patches (see *.patch). Not a fork.
# youtube-scopes.patch: request only the YouTube scopes Postiz uses (Google OAuth verification).
# tiktok-creator-info.patch: dashboard-callable TiktokProvider.creatorInfo (PostMarga, TikTok Direct Post rules).
# preview-url.patch: MCP previewUrl uses PREVIEW_URL (branded host) when set, else FRONTEND_URL.
# Build: ./build.sh <postiz version>
ARG POSTIZ_VERSION=v2.25.3
FROM ghcr.io/gitroomhq/postiz-app:${POSTIZ_VERSION}

RUN apt-get update && apt-get install -y --no-install-recommends patch \
 && rm -rf /var/lib/apt/lists/*

COPY *.patch /tmp/patches/
# Fails the build if a patch no longer matches the upstream source.
RUN for p in /tmp/patches/*.patch; do patch -p1 --forward --fuzz=0 -d /app < "$p" || exit 1; done

# Only backend + orchestrator use the providers; frontend is untouched.
RUN NODE_OPTIONS="--max-old-space-size=4096" pnpm run build:backend \
 && NODE_OPTIONS="--max-old-space-size=4096" pnpm run build:orchestrator \
 && ! grep -rq "auth/youtubepartner" apps/backend/dist apps/orchestrator/dist \
 && grep -rq "creatorInfo" apps/backend/dist \
 && grep -rq "PREVIEW_URL" apps/backend/dist/libraries/nestjs-libraries/src/chat/tools/integration.schedule.post.js
