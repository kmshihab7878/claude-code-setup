# Autoresearch Template: Aster DEX Trading

Adapted from Nunchi's auto-researchtrading (Hyperliquid) for Aster DEX perpetual futures and spot trading.

## Architecture

```
Target:     strategy.py          (your trading strategy — the ONLY mutable file)
Harness:    backtest.py          (fixed evaluation engine)
Data:       prepare.py           (data pipeline via Aster MCP tools)
Scoring:    compute_score()      (composite risk-adjusted metric)
Loop:       /autoresearch        (Claude Code autonomous loop)
```

## Aster DEX Differences from Hyperliquid

| Aspect | Hyperliquid (Original) | Aster DEX (Adapted) |
|--------|----------------------|---------------------|
| API | REST POST to api.hyperliquid.xyz | Aster MCP tools (stdio) |
| Markets | BTC, ETH, SOL perps | All Aster futures + spot pairs |
| Data source | CryptoCompare + HL candles | `mcp__aster__get_klines` + `mcp__aster__get_spot_klines` |
| Funding | HL funding history API | `mcp__aster__get_funding_rate` + `mcp__aster__get_funding_info` |
| Order book | Not used in backtest | `mcp__aster__get_order_book` (available for microstructure) |
| Fees | 2bps maker / 5bps taker / 1bps slip | Check via `mcp__aster__get_commission_rate` |
| Leverage | Max 20x | Check via `mcp__aster__get_leverage_bracket` |

## MCP Tool Mapping for Data Pipeline

### Market Data (for prepare.py)
```python
# Klines (OHLCV candles)
mcp__aster__get_klines(symbol="BTCUSDT", interval="1h", limit=500)
mcp__aster__get_spot_klines(symbol="BTCUSDT", interval="1h", limit=500)

# Funding rates
mcp__aster__get_funding_rate(symbol="BTCUSDT")
mcp__aster__get_funding_info()  # all symbols

# Current prices
mcp__aster__get_ticker(symbol="BTCUSDT")
mcp__aster__get_spot_ticker(symbol="BTCUSDT")

# Order book depth
mcp__aster__get_order_book(symbol="BTCUSDT", limit=20)
```

### Account Data (for position tracking)
```python
mcp__aster__get_positions()
mcp__aster__get_balance()
mcp__aster__get_account_info()
mcp__aster__get_income()  # P&L history
mcp__aster__get_my_trades()
```

### Order Execution (for live deployment after backtesting)
```python
mcp__aster__create_order(symbol, side, type, quantity, price, ...)
mcp__aster__cancel_order(symbol, orderId)
mcp__aster__set_leverage(symbol, leverage)
mcp__aster__set_margin_mode(symbol, marginMode)
```

## Scoring Formula (Adapted)

```python
def compute_score(result):
    """Composite risk-adjusted score. HIGHER is better."""
    # Hard cutoffs
    if result.num_trades < 10: return -999.0
    if result.max_drawdown_pct > 50.0: return -999.0
    if result.final_equity < initial_capital * 0.5: return -999.0

    # Core metric
    trade_count_factor = min(result.num_trades / 50.0, 1.0)
    drawdown_penalty = max(0, result.max_drawdown_pct - 15.0) * 0.05
    turnover_ratio = result.annual_turnover / initial_capital
    turnover_penalty = max(0, turnover_ratio - 500) * 0.001

    # Aster-specific: add fee-adjusted return bonus
    fee_drag = result.total_fees / initial_capital
    fee_efficiency = max(0, result.total_return_pct / 100 - fee_drag) * 0.1

    score = (result.sharpe * math.sqrt(trade_count_factor)
             - drawdown_penalty - turnover_penalty + fee_efficiency)
    return score
```

## Strategy Template

```python
"""
Aster DEX Trading Strategy
Mutable file — autoresearch loop modifies this.
"""
import numpy as np
from prepare import Signal, PortfolioState, BarData

ACTIVE_SYMBOLS = ["BTCUSDT", "ETHUSDT", "SOLUSDT"]

# --- Parameters (tune these) ---
EMA_FAST = 7
EMA_SLOW = 26
RSI_PERIOD = 8
ATR_STOP_MULT = 5.5
BASE_POSITION_PCT = 0.08
MIN_VOTES = 4  # ensemble voting threshold

class Strategy:
    def __init__(self):
        self.entry_prices = {}
        self.peak_prices = {}
        self.exit_bar = {}
        self.bar_count = 0

    def on_bar(self, bar_data, portfolio):
        signals = []
        # ... strategy logic ...
        # Return list of Signal(symbol, target_position)
        return signals
```

## Research Directions for Aster DEX

### Tier 1 — High probability (start here)
- **Funding rate carry**: Aster perps have funding — trade the carry
- **Multi-asset momentum**: BTC/ETH/SOL ensemble with majority voting
- **ATR trailing stops**: Adaptive exits based on volatility
- **Vol-regime sizing**: Reduce size in high vol, increase in low vol
- **EMA crossover + RSI confirmation**: Proven hourly-timeframe signals

### Tier 2 — Worth exploring
- **Spot-futures basis trading**: Aster has both spot and futures
- **Cross-exchange funding arbitrage**: Compare Aster funding vs. other venues
- **Order book imbalance**: Use `get_order_book` for microstructure signals
- **Dynamic leverage**: Adjust leverage based on conviction and vol regime
- **Correlation regime switching**: Different strategies for high/low correlation periods

### Tier 3 — Novel / Aster-specific
- **Spot accumulation on dips**: Use spot orders to accumulate during drawdowns
- **Funding rate mean reversion**: Trade the mean reversion of funding itself
- **Volume profile strategies**: Aster volume patterns may differ from centralized exchanges
- **Transfer-based signals**: Monitor `transfer_funds` flows for sentiment

## Setup Workflow

1. **Clone the autoresearch template**:
   ```bash
   mkdir ~/aster-autoresearch && cd ~/aster-autoresearch
   ```

2. **Create prepare.py**: Data pipeline using Aster MCP tools
   - Download klines for target symbols
   - Merge funding rate data
   - Save as parquet for fast backtesting

3. **Create backtest.py**: Fixed evaluation harness
   - Load data, run strategy, compute metrics
   - Use the scoring formula above

4. **Create strategy.py**: Initial baseline strategy
   - Start with simple momentum (the proven baseline)
   - This is the ONLY file the autoresearch loop modifies

5. **Launch the loop**:
   ```
   /autoresearch strategy.py "uv run backtest.py" "score:"
   ```

## Integration with Existing Skills

- **aster-trading skill**: MCP tool reference, risk rules, position limits
- **finance-ml skill**: Technical indicators, backtesting methodology, risk metrics
- **autoresearch skill**: Loop protocol, scoring patterns, experiment tracking
- **finance-tracker agent**: P&L analysis, fee impact tracking
- **experiment-tracker agent**: Statistical analysis of experiment results
