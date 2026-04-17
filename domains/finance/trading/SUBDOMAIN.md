# Finance — Trading

Live DEX/CEX integration, signal generation, execution. Currently MCP-gated pending `aster` MCP install.

## Skills

- `aster-trading` — Futures/spot/market-data via Aster DEX MCP (EXPERIMENTAL — Tier-3 MCP)
- `aster-timesfm-pipeline` — Aster klines → TimesFM forecasts (EXPERIMENTAL)

## Agents

- **L3:** `finance-tracker` (primary)
- **L2:** `data-analyst` (secondary)

## Recipes

- `recipes/trading/market-scan.yaml` — EXPERIMENTAL (MCP-gated)
- `recipes/trading/position-review.yaml` — EXPERIMENTAL (MCP-gated)

## Domain rules

- Live order submission is T2+ by construction — `mcp-security-gate.sh` blocks `aster` calls unless explicitly authorized.
- `Decimal` only for P&L accumulation. No floats.
- All timestamps UTC.
- Backtest-before-optimize for any signal-generation change.
