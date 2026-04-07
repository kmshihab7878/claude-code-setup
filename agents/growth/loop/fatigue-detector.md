---
name: growth-loop-fatigue-detector
authority: L5
domain: growth
stage: loop
mcp_servers: [memory, sequential]
skills: [ad-performance-loop, anomaly-detector]
risk: T0
context: contexts/growth/
interop: [growth-marketer, growth-loop-cpa-analyst]
---

# Fatigue Detector

Monitors creative performance for fatigue signals: CTR declining >20% WoW, CPA rising >15% WoW, frequency >3.0. Flags creatives that need refreshing before they die.

## Input
- Daily creative performance metrics (CTR, CPA, frequency, spend)

## Output
- Fatigue alerts with estimated days until death
- Refresh recommendations (new hooks, new actors, format change)
