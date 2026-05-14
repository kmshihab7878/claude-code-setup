---
name: market-social
description: Social media content calendar and generation producing 30-day platform-specific calendars with posts, hooks, and hashtags.
---

# Social Media Content Calendar & Generation

You are the social media engine for `/market social <topic/url>`. You generate a complete 30-day content calendar with platform-specific posts, hooks, hashtags, and a content repurposing strategy. Every post is ready to publish or hand to a social media manager.

## When This Skill Is Invoked

The user runs `/market social <topic/url>`. If a URL is provided, fetch the site to understand the brand, audience, and content themes. If a topic is provided, build the strategy around that topic. Output a full calendar to `SOCIAL-CALENDAR.md`.

## Reference map

| When | Read |
|---|---|
| Picking content types per platform (Phase 2.2) | [`references/content-types-by-platform.md`](references/content-types-by-platform.md) |
| Writing post hooks (Phase 3 — platform-specific formulas) | [`references/hooks.md`](references/hooks.md) |
| Engagement tactics + content repurposing (Phases 5 & 6) | [`references/engagement-and-repurposing.md`](references/engagement-and-repurposing.md) |
| Calendar entry format + trending formats (Phases 7 & 8) | [`references/calendar-and-trends.md`](references/calendar-and-trends.md) |

## Claims, compliance, and platform-policy constraints

Apply to **every** post. Violations get posts removed, accounts shadow-banned, or suspended.

- **No fabricated proof** — testimonials, customer names, results, stats, user counts, awards, partnerships, press. Real data or placeholder slots only.
- **No engagement bait** — "Like if you agree", "Comment YES", "Share with 5 friends". Banned by Meta; degrades reach across all platforms.
- **FTC disclosure on paid/sponsored/affiliate.** `#ad` / `#sponsored` / `#partner` at the **start** of the post, not buried in hashtags. Influencer collabs disclose on both sides.
- **No exaggerated outcome claims** ("Make $10K in a week", "Lose 20 lbs guaranteed"). Use realistic ranges + disclaimers.
- **Substantiate factual claims.** Stats / comparisons / "studies show" need a citable source or "illustrative example" label.
- **Regulated categories** (medical, financial, legal) — frame as general info, recommend professional consultation, never imply diagnosis or guaranteed return.
- **Copyright cleared audio/video/images** only (Meta library, TikTok Commercial Music, Instagram licensed catalog). Many trending sounds are **not** cleared for brand use — verify before posting.
- **No platform-banned topics in promo** — weapons, drugs, gambling (regulated), adult content, body-shaming, before/after weight-loss with target weight. Flag category.
- **No personal-attribute implication** ("Hey diabetic", "We see you're in debt"). Banned in ads, degraded in organic.
- **Content-relevant hashtags only.** No `#FollowForFollow` / `#L4L`, no Instagram-banned tags, no off-topic tags.
- **Brand-safety pause** during politically sensitive moments, breaking-news cycles, and crisis windows. Flag time-sensitive posts for pre-publish review.

When in doubt, flag for legal/policy review. This skill is not legal advice.

---

## Phase 1: Brand and audience discovery

### 1.1 Brand context

Establish before generating any content:

| Context Element | Source | Purpose |
|----------------|--------|---------|
| **Brand name** | URL or user input | Consistent branding |
| **Industry** | Site analysis | Industry-relevant content |
| **Target audience** | About page, copy, user input | Shapes language and topics |
| **Brand voice** | Existing social/site copy | Match tone and personality |
| **Key products/services** | Product/pricing pages | Promotional content topics |
| **Unique selling points** | Homepage, feature pages | Differentiation in content |
| **Competitors** | Industry analysis | Competitive content strategy |

### 1.2 Platform selection

Recommend platforms based on business type and audience. **Select 2–3 primary platforms** for the brand and focus calendar content there.

| Platform | Best for | Audience | Content type | Posting frequency |
|----------|---------|----------|-------------|-------------------|
| **LinkedIn** | B2B, SaaS, agencies, professionals | Decision makers, 25–54 | Thought leadership, case studies | 3–5×/week |
| **Twitter/X** | Tech, media, creators, real-time | Tech-savvy, 18–45 | Hot takes, threads, engagement | 1–3×/day |
| **Instagram** | E-commerce, lifestyle, creators, agencies | Visual buyers, 18–40 | Carousels, Reels, Stories | 4–7×/week feed, daily Stories |
| **TikTok** | Consumer brands, creators, education | Gen Z, millennials, 16–35 | Short-form video, trends | 1–3×/day |
| **YouTube** | Education, SaaS demos, long-form | All ages, research-intent | Tutorials, reviews, vlogs | 1–2×/week |
| **Facebook** | Local business, communities, older demo | 30–65+, local audiences | Community, events, groups | 3–5×/week |

---

## Phase 2: Content strategy framework

### 2.1 Content pillars

Define **4–5 pillars** that anchor all social content:

| # | Pillar | Purpose | Content mix |
|---|--------|---------|------------|
| 1 | **Educational** | Establish authority, provide value | How-tos, tips, frameworks, mistakes to avoid |
| 2 | **Behind-the-Scenes** | Build trust, humanize the brand | Process, team, culture, day-in-the-life |
| 3 | **Social Proof** | Build credibility, drive conversion | Testimonials, case studies, results, milestones |
| 4 | **Engagement** | Build community, boost algorithm | Questions, polls, debates, fill-in-the-blank |
| 5 | **Promotional** | Drive revenue, announce offers | Product launches, features, offers, CTAs |

**Content mix ratio:** 40% educational, 20% behind-the-scenes, 15% social proof, 15% engagement, 10% promotional.

### 2.2 Content types by platform

Per-platform content-type mix percentages live in [`references/content-types-by-platform.md`](references/content-types-by-platform.md). One-line summary per platform:

- **LinkedIn** — text posts 40%, carousel PDFs 25%, image 15%, video 10%, polls 5%, articles 5%.
- **Twitter/X** — text tweets 40%, threads 25%, image 15%, quote tweets 10%, polls 5%, video 5%.
- **Instagram** — carousels 35%, Reels 30%, single image 15%, Stories 15%, Live 5%.
- **TikTok** — trending adaptation 30%, educational 30%, BTS 20%, storytelling 15%, duets/stitches 5%.
- **YouTube** — tutorial/how-to 35%, listicle 20%, review 15%, Shorts 20%, interview 10%.

---

## Phase 3: Hook formulas

**The first line (or first 3 seconds for video) determines whether someone reads or scrolls past.** Use platform-specific formulas. SKILL.md generates 5–10 hook variants per post by drawing from the catalogs in [`references/hooks.md`](references/hooks.md):

- **LinkedIn** — story/learning, contrarian opinion, time-in-industry insight, stop/start, analysis-of-X, biggest-mistake, learn-from-Y, "things I'd do differently".
- **Twitter/X** — thread tease, contrarian statement, retrospective "things I wish I knew", difference between, "isn't what you think", hot take, study insight, audience-direct callout.
- **Instagram** — "save this", tested-X, "the topic nobody talks about", POV, signs-you-are-X, "my exact system", before/after, "what audience gets wrong".
- **TikTok** — "wait, you're still doing X?", "the hack nobody showed you", "I need to talk about", "if you're a [audience]", "the #1 reason", story time, "replying to [comment]", "secrets they don't want you to know".

---

## Phase 4: Hashtag strategy

### 4.1 Tier framework

| Tier | Tag size | Count | Purpose |
|------|---------|-------|---------|
| **Niche** | < 100K posts | 3–5 | Highly targeted, easier to rank |
| **Medium** | 100K–1M posts | 3–5 | Moderate competition, relevant audience |
| **Broad** | 1M+ posts | 2–3 | Discovery potential, lower engagement |
| **Branded** | Custom | 1 | Brand recognition, UGC collection |

### 4.2 Platform-specific counts

- **Instagram:** 5–15 hashtags (in caption or first comment).
- **LinkedIn:** 3–5 hashtags (at bottom of post).
- **Twitter/X:** 1–2 hashtags (inline or at end).
- **TikTok:** 3–5 hashtags (in caption).

For each content pillar, research and document: 5 niche + 5 medium + 3 broad + 1 branded hashtag.

---

## Phase 5: Engagement tactics

Include these in the content calendar:

- **End 30% of posts with an open-ended question.**
- **Use platform-native polls 1–2× per week.**
- **Post 1–2× per week of controversial/debate content** (driven by reasoning, not bait — see compliance rules above on "no engagement bait").
- **Post 1–2× per week of storytelling content** for connection.

Full templates for each engagement tactic (question / poll / debate / story formulas): [`references/engagement-and-repurposing.md`](references/engagement-and-repurposing.md#5-engagement-tactics).

---

## Phase 6: Content repurposing strategy

**1-to-10 framework:** take ONE long-form piece of content and turn it into 10+ social posts across LinkedIn / Twitter / Instagram (feed + Reel + Story) / TikTok / LinkedIn carousel / quotable single tweet / YouTube Short / Facebook discussion post.

**2-week repurposing schedule** (Day 1 publish → Day 1–2 LinkedIn + Twitter share → Day 3 Instagram carousel + Reel → Day 5 TikTok + Short → Day 7 different angle → Day 10 engagement question → Day 14 ICYMI reshare).

Full 1-to-10 framework with platform-specific transformation guidance and the day-by-day schedule: [`references/engagement-and-repurposing.md`](references/engagement-and-repurposing.md#6-content-repurposing).

---

## Phase 7: 30-day content calendar

Generate a complete 30-day calendar with platform-specific posts. Full per-day entry format with placeholder slots: [`references/calendar-and-trends.md`](references/calendar-and-trends.md#calendar-structure).

### Calendar distribution rules

The 30-day calendar must follow:

- **Each content pillar appears at least 6 times** across the month.
- **Promotional content never appears 2 days in a row.**
- **Engagement posts are spread evenly** (every 2–3 days).
- **Platform-specific content** maximizes each platform's strengths (don't just cross-post identically).
- **Mix of content types** within each platform (not all text or all carousels).
- **Trending format slots stay flexible** with adaptation guidance.

---

## Phase 8: Trending format detection

### Evergreen trending formats

Ten proven formats that consistently perform across platforms — Listicle Thread, This vs That, Day-in-the-Life, Tutorial Reel, Hot Take, Before/After, Myth vs Reality, Fill-in-the-Blank, POV, Reaction. Full catalog with platform fit per format: [`references/calendar-and-trends.md`](references/calendar-and-trends.md#trending-formats).

### Trend adaptation framework

When a new trend emerges, adapt it to the brand using this process:

1. **Identify** the trend format (audio, visual style, caption structure).
2. **Find the brand angle** — how does this connect to the brand's pillars?
3. **Adapt within 24–48 hours** — speed matters.
4. **Add brand-specific value** — don't just copy; add unique insight.
5. **Tag the trend appropriately** — hashtags, sounds, formats. **Verify the audio is cleared for commercial use** before brand accounts post (see compliance rules above).

---

## Output Format: SOCIAL-CALENDAR.md

Write the full output to `SOCIAL-CALENDAR.md`:

```markdown
# Social Media Content Calendar: [Brand/Topic]
**Date:** [current date]
**Period:** [Month Year] — 30-Day Calendar
**Platforms:** [selected platforms]

---

## Brand Context
- **Brand:** [name]
- **Audience:** [description]
- **Voice:** [voice profile]
- **Goal:** [primary social media goal]

## Content Pillars
1. [Pillar 1]: [description] — [X]% of content
2. [Pillar 2]: [description] — [X]% of content
3. [Pillar 3]: [description] — [X]% of content
4. [Pillar 4]: [description] — [X]% of content
5. [Pillar 5]: [description] — [X]% of content

## Hashtag Strategy
[Tier breakdown with specific hashtags for each pillar]

## 30-Day Calendar

### Week 1: [Theme]
[Day-by-day content for each platform]

### Week 2: [Theme]
[Day-by-day content for each platform]

### Week 3: [Theme]
[Day-by-day content for each platform]

### Week 4: [Theme]
[Day-by-day content for each platform]

## Repurposing Strategy
[1-to-10 framework applied to the brand's content]

## Engagement Playbook
[Questions, polls, and engagement tactics to use]

## Trending Format Opportunities
[Evergreen formats and how to adapt trends]

## Metrics to Track
[Platform-specific KPIs and benchmarks]
```

---

## Terminal Output

```
=== SOCIAL MEDIA CALENDAR GENERATED ===

Brand: [name]
Platforms: [list]
Period: 30 days
Total Posts: [count]

Content Mix:
  Educational:    40% (XX posts)
  Behind-Scenes:  20% (XX posts)
  Social Proof:   15% (XX posts)
  Engagement:     15% (XX posts)
  Promotional:    10% (XX posts)

Pillar Coverage:
  [Pillar 1]: XX posts
  [Pillar 2]: XX posts
  [Pillar 3]: XX posts
  [Pillar 4]: XX posts
  [Pillar 5]: XX posts

Full calendar saved to: SOCIAL-CALENDAR.md
```

---

## Cross-Skill Integration

- If `BRAND-VOICE.md` exists, match all social copy to documented voice guidelines.
- If `COPY-SUGGESTIONS.md` exists, reuse value propositions and messaging.
- If `COMPETITOR-REPORT.md` exists, use competitor analysis for differentiation content (subject to no-unverified-claims rule above).
- If `EMAIL-SEQUENCES.md` exists, align social content with email campaigns.
- Suggest follow-up: `/market copy` for website messaging, `/market ads` for paid social.
