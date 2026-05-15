# Backtesting, Risk, And Validation

Purpose: detailed reference for risk metrics, walk-forward testing, validation controls, and performance interpretation.

## Common Pitfalls

| Pitfall | Description | Prevention |
|---------|-------------|------------|
| Look-ahead bias | Future data appears in decisions | Strict timestamp alignment and walk-forward splits |
| Survivorship bias | Only survivors remain in the universe | Use point-in-time universe data |
| Overfitting | Model learns noise | Out-of-sample tests and parameter sensitivity |
| Ignored costs | Fees and slippage omitted | Add realistic cost and fill assumptions |
| Data snooping | Too many strategies tested | Holdout set and multiple-test caution |
| Misfit benchmark | Strategy compared to weak baseline | Use buy-and-hold, equal-weight, or naive signal baselines |

## Walk-Forward Validation

```python
import pandas as pd
from collections.abc import Callable

def walk_forward_backtest(
    data: pd.DataFrame,
    train_window: int = 252,
    test_window: int = 21,
    strategy_fn: Callable[[pd.DataFrame], object] | None = None,
) -> pd.Series:
    """Walk-forward out-of-sample backtest."""
    if strategy_fn is None:
        raise ValueError("strategy_fn is required")

    results = []
    for start in range(0, len(data) - train_window - test_window, test_window):
        train = data.iloc[start:start + train_window]
        test = data.iloc[start + train_window:start + train_window + test_window]

        model = strategy_fn(train)
        predictions = model.predict(test)
        results.append(predictions)

    return pd.concat(results)
```

## Risk Metrics

```python
import numpy as np
import pandas as pd

def sharpe_ratio(
    returns: pd.Series,
    risk_free_rate: float = 0.04,
    periods_per_year: int = 252,
) -> float:
    """Annualized Sharpe Ratio."""
    excess = returns - risk_free_rate / periods_per_year
    return np.sqrt(periods_per_year) * excess.mean() / excess.std()

def sortino_ratio(
    returns: pd.Series,
    risk_free_rate: float = 0.04,
    periods_per_year: int = 252,
) -> float:
    """Sortino Ratio using downside deviation."""
    excess = returns - risk_free_rate / periods_per_year
    downside = excess[excess < 0].std()
    return np.sqrt(periods_per_year) * excess.mean() / downside if downside > 0 else 0.0

def max_drawdown(equity_curve: pd.Series) -> float:
    """Maximum drawdown as a negative percentage."""
    peak = equity_curve.cummax()
    drawdown = (equity_curve - peak) / peak
    return drawdown.min()

def value_at_risk(
    returns: pd.Series,
    confidence: float = 0.95,
    method: str = "historical",
) -> float:
    """Value at Risk."""
    if method == "historical":
        return np.percentile(returns, (1 - confidence) * 100)
    if method == "parametric":
        from scipy import stats

        z_score = stats.norm.ppf(1 - confidence)
        return returns.mean() + z_score * returns.std()
    raise ValueError(f"Unknown method: {method}")

def calmar_ratio(
    returns: pd.Series,
    periods_per_year: int = 252,
) -> float:
    """Calmar Ratio: annual return divided by max drawdown."""
    annual_return = returns.mean() * periods_per_year
    mdd = abs(max_drawdown((1 + returns).cumprod()))
    return annual_return / mdd if mdd > 0 else 0.0
```

## Performance Interpretation

- Sharpe can hide tail risk and unstable regimes.
- Sortino focuses on downside volatility but still depends on the return distribution.
- Max drawdown shows path pain and capital impairment.
- VaR is sensitive to distribution assumptions and confidence level.
- Calmar is useful when drawdown is a primary constraint.
- Turnover and exposure are required for tradeability.

## Validation Checklist

- Train, validation, and test windows are chronological.
- Labels are shifted forward and unavailable rows are dropped.
- Scalers and encoders are fit only on training data.
- Costs and slippage are included.
- Benchmarks are documented.
- Metrics include both prediction quality and portfolio/trading outcomes.
- Results are reported with caveats and not presented as guaranteed future performance.
