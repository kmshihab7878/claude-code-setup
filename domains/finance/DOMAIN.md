# Finance — Domain Index

> Lazy-loaded index for quantitative trading, market analysis, and portfolio management. Files are not moved; this doc points at their canonical locations.

## When to activate

Trigger keywords / intent patterns:

- *trade, trading, market, portfolio, risk, backtest, forecast, price, volatility, position, P&L, Sharpe, Sortino, VaR, DCF, valuation, option, futures, spot, kline*
- File change patterns: any code importing `pandas`, `numpy`, `vectorbt`, `backtrader`, `yfinance`, time-series notebooks, anything under a `trading/` or `finance/` subdir in a target repo
- Domain classifier output: `finance`, `trading`, `portfolio`, `quant`

## Subdomains

| Subdomain | Scope | See |
|-----------|-------|-----|
| [trading](./trading/SUBDOMAIN.md) | Live DEX/CEX integration, signal generation, execution | — |
| [analysis](./analysis/SUBDOMAIN.md) | Price forecasting, anomaly detection, market scanning | — |
| [portfolio](./portfolio/SUBDOMAIN.md) | Risk metrics, allocation, DCF, valuation | — |

## Commands

No dedicated finance-only commands yet. Route via:

- `/plan` with finance context — orchestrator routes to `finance-tracker` / `data-analyst`
- `/ultraplan` for cross-system (strategy + trading + risk) decisions
- `/recall` to retrieve prior trading or research conversations

## Relevant agents

**Primary (L3):** `finance-tracker` — central finance operator. Binds `aster`, `sequential-thinking`, `memory`. Depends on `aster-trading`, `finance-ml`, `financial-modeling`, `wshobson-SKILL`.

**Supporting:**

- `data-analyst` (L2) — handles analysis pipelines; binds `postgres` and `aster`.
- `analytics-reporter` (L3) — financial metric dashboards.
- `business-panel-experts` (L1) — invokes `cfo-advisor` / `ciso-advisor` for strategic finance/risk decisions.

**Wave 1 growth-loop agents that carry finance-ish content:** `growth/loop/roas-optimizer.md`, `growth/loop/attribution-analyst.md`, `growth/loop/cpa-analyst.md` — live under `growth/` because they're marketing-finance, but the formulas are shared. Cross-reference these from `domains/marketing/DOMAIN.md`.

## Skill index

| Skill | Subdomain | Status | Notes |
|-------|-----------|--------|-------|
| `aster-trading` | trading | EXPERIMENTAL | Futures/spot/market-data via Aster DEX MCP (Tier-3 aspirational) |
| `aster-timesfm-pipeline` | trading/analysis | EXPERIMENTAL | Aster klines → TimesFM forecasts; MCP-gated |
| `financial-modeling` | portfolio | SUPPORTING | DCF, Monte Carlo, portfolio optimization, risk metrics |
| `financial-analyst` | portfolio | SUPPORTING | Ratio analysis, DCF valuation, variance, rolling forecasts |
| `finance-ml` | analysis | SUPPORTING | Price prediction, technical indicators, risk metrics |
| `timesfm-forecasting` | analysis | SUPPORTING | Zero-shot TimesFM forecasting (works for any univariate series, not just finance) |
| `wshobson-SKILL` | portfolio | SUPPORTING | VaR, CVaR, Sharpe, Sortino, drawdown — portfolio risk toolkit |
| `revenue-operations` | portfolio/ops | SUPPORTING | Sales pipeline + revenue forecasting accuracy |
| `pricing-strategy` | portfolio/strategy | SUPPORTING | SaaS tier structure + value metrics |
| `sales-engineer` | portfolio/ops | SUPPORTING | RFP/RFI coverage gap analysis |
| `finance-tracker` | portfolio | SUPPORTING | The agent above binds this skill (alias of `financial-modeling` + `wshobson-SKILL`) |

### Cross-domain skills used by finance

`data-analysis` (CORE engineering) — natural language → SQL/pandas; heavily used for market-data exploration.
`research-methodology` (CORE engineering) — due diligence + multi-hop reasoning for investment analysis.
`anomaly-detector` (SUPPORTING operations) — metric-drift detection, adaptable to price / volume anomalies.
`cfo-advisor` (C-suite) — fundraising + unit economics + cash runway framing.
`ciso-advisor` (C-suite) — compliance landscape for regulated finance workflows.
`claude-api` (CORE ai-ml) — building agentic finance tools.

## Domain rules

1. **No paper-trading in production code paths.** If a skill or agent touches live order submission, that path must be gated by an explicit user confirmation (T2+) regardless of the code's stated risk level.
2. **Backtest before optimizing.** When modifying a forecasting or signal-generation skill, a regression run against a stored fixture is mandatory.
3. **No silent floating-point aggregation.** Accumulated trading P&L must use `Decimal` or fixed-point; if a skill demos otherwise, flag for review.
4. **Timestamp discipline.** Kline and tick data must carry explicit tz (UTC) — CLAUDE.md's root rule about date interpretation applies doubly here.
5. **Aspirational-MCP caveat.** Most finance skills depend on the `aster` MCP (Tier-3 aspirational). Their demo modes work with offline fixtures; live mode requires `claude mcp add aster` first.

## Recipes

| Recipe | Engine | Notes |
|--------|--------|-------|
| `recipes/trading/market-scan.yaml` | `data-analyst → finance-tracker` | Market scanner; `aster` required |
| `recipes/trading/position-review.yaml` | `finance-tracker → data-analyst` | Portfolio posture review; `aster` required |

Both are EXPERIMENTAL pending MCP install.

## Notes

- **Finance is currently under-developed relative to engineering and marketing.** No dedicated finance commands. No production-ready recipes. Skills are present but the backing MCP is aspirational.
- **Extraction candidate:** the `timesfm-forecasting` skill is domain-agnostic (the global-temperature demo proves it). It's categorized here because forecasting is the most user-requested use case, but the skill itself is general-purpose and could live as a standalone product.
- **Growth-finance overlap:** the three `growth/loop/*` agents (roas-optimizer, attribution-analyst, cpa-analyst) compute ROAS/CAC/LTV which are marketing-flavored but use portfolio-style math. Keep their canonical location under `agents/growth/` but allow finance-tracker to invoke them for cross-domain analysis.
- **Elevation path:** once `aster` MCP is installed, `aster-trading` and `aster-timesfm-pipeline` move from EXPERIMENTAL to SUPPORTING, and the two trading recipes become executable.
