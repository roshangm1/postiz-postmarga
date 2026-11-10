# PostMarga modifications to Postiz

This is a modified version of [Postiz](https://github.com/gitroomhq/postiz-app). Postiz is licensed under the
GNU Affero General Public License v3.0 (see [LICENSE](LICENSE)). This repository is the Corresponding Source of
the Postiz instance behind [Post Marga](https://postmarga.com), published under AGPL-3.0 section 13.

- **Base:** upstream tag `v2.25.3` (commit `a5affe62c74e39c1e7ac960d50d8418b807d532c`)
- **Branch:** `postmarga/v2.25.3`, upstream `v2.25.3` plus the commits listed below
- **Running build:** the official `ghcr.io/gitroomhq/postiz-app:v2.25.3` image with the patches in
  [`postmarga/patches/`](postmarga/patches) applied and the backend and orchestrator rebuilt
  ([`postmarga/Dockerfile`](postmarga/Dockerfile), [`postmarga/build.sh`](postmarga/build.sh)). The frontend is not modified.

## Changes

| Date | Files | Change |
|---|---|---|
| 2026-11-05 | `libraries/nestjs-libraries/src/integrations/social/youtube.provider.ts` | The YouTube provider requests only the scopes Postiz uses (profile, email, `youtube.readonly`, `youtube.upload`, `yt-analytics.readonly`), which Google OAuth verification requires. |
| 2026-11-05, 2026-11-08 | `libraries/nestjs-libraries/src/integrations/social/tiktok.provider.ts` | Adds the `creatorInfo` dashboard function, which returns TikTok's `creator_info` for Direct Post compliance. Throws `RefreshToken` on `access_token_invalid` so the token is refreshed and the call retried. |
| 2026-11-10 | `libraries/nestjs-libraries/src/chat/tools/integration.schedule.post.ts` | The MCP `previewUrl` uses the `PREVIEW_URL` env var when it is set, otherwise `FRONTEND_URL`. |

In the source, each change is marked with a `PostMarga:` comment.

## Not part of Postiz

Public preview pages on `preview.postmarga.com` show Post Marga branding (title, logo, font, button color).
A separate reverse proxy rewrites the HTML on the way out; the Postiz code for those pages is unchanged.

## Building

```sh
cd postmarga && ./build.sh v2.25.3   # -> image postiz-patched:v2.25.3
```
