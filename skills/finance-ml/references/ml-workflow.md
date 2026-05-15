# Finance ML Workflow

Purpose: deeper operating workflow for finance ML projects, including data sourcing, task framing, trading signal packaging, and portfolio work.

## Task Framing

Start by separating the analysis goal from the trading decision:

- Forecasting: estimate future return, price, volatility, or drawdown.
- Classification: predict direction, regime, anomaly, default, or event risk.
- Ranking: sort assets by expected return, risk-adjusted score, or factor exposure.
- Allocation: choose portfolio weights under risk and constraint assumptions.
- Execution support: propose a signal package that still requires explicit approval before any order action.

## Data Sources

FinanceDatabase can be used for instrument discovery:

```python
import financedatabase as fd

equities = fd.Equities()
etfs = fd.ETFs()
funds = fd.Funds()
currencies = fd.Currencies()
cryptos = fd.Cryptos()

tech_stocks = equities.search(sector="Technology", country="United States")
tickers = tech_stocks.index.tolist()
```

Market data options:

| Library | Data Type | Free Tier |
|---------|-----------|-----------|
| `yfinance` | Price, fundamentals, options | Yes |
| `financedatabase` | Instrument metadata | Yes |
| `alpha_vantage` | Price, forex, crypto | API key |
| `ccxt` | Crypto exchange data | Yes |
| `pandas-datareader` | FRED, World Bank, OECD | Yes |

Fetch OHLCV data:

```python
import yfinance as yf

btc = yf.download("BTC-USD", start="2024-01-01", interval="1d")
```

## Standard Project Flow

1. Define the target and horizon.
2. Gather point-in-time data.
3. Clean timestamps, missing bars, corporate actions, and symbol changes.
4. Build features from past information only.
5. Create labels after feature generation.
6. Split by time.
7. Train a baseline.
8. Train candidate models.
9. Backtest with realistic assumptions.
10. Stress test by regime and parameter sensitivity.
11. Package evidence and limitations.

## Portfolio Optimization

Mean-variance optimization:

```python
from scipy.optimize import minimize
import numpy as np
import pandas as pd

def optimize_portfolio(
    returns: pd.DataFrame,
    risk_free_rate: float = 0.04,
) -> dict:
    """Mean-variance portfolio optimization."""
    n_assets = returns.shape[1]
    mean_returns = returns.mean() * 252
    cov_matrix = returns.cov() * 252

    def neg_sharpe(weights: np.ndarray) -> float:
        port_return = np.dot(weights, mean_returns)
        port_vol = np.sqrt(np.dot(weights.T, np.dot(cov_matrix, weights)))
        return -(port_return - risk_free_rate) / port_vol

    constraints = [{"type": "eq", "fun": lambda w: np.sum(w) - 1}]
    bounds = [(0, 1) for _ in range(n_assets)]
    initial = np.array([1 / n_assets] * n_assets)

    result = minimize(
        neg_sharpe,
        initial,
        method="SLSQP",
        bounds=bounds,
        constraints=constraints,
    )

    optimal_weights = result.x
    return {
        "weights": dict(zip(returns.columns, optimal_weights)),
        "expected_return": float(np.dot(optimal_weights, mean_returns)),
        "volatility": float(np.sqrt(np.dot(optimal_weights.T, np.dot(cov_matrix, optimal_weights)))),
        "sharpe": float(-result.fun),
    }
```

## Aster DEX Signal Workflow

1. Fetch market data: `get_klines(symbol, interval="1h", limit=500)`.
2. Calculate features from technical indicators and ML predictions.
3. Generate signal: `BUY`, `SELL`, or `HOLD` with confidence.
4. Run risk checks:
   - position size via fractional Kelly or fixed fractional sizing;
   - current positions via `get_positions()`;
   - available balance via `get_balance()`;
   - max loss and liquidation-risk checks.
5. Present signal, confidence, position size, and risk metrics.
6. Require user confirmation before order action.
7. If approved, execute through the relevant trading tool.
8. Monitor position and report state changes.

Position sizing:

```python
def kelly_criterion(
    win_rate: float,
    avg_win: float,
    avg_loss: float,
    fraction: float = 0.25,
) -> float:
    """Fractional Kelly position sizing."""
    kelly = (win_rate * avg_win - (1 - win_rate) * avg_loss) / avg_win
    return max(0, kelly * fraction)
```
