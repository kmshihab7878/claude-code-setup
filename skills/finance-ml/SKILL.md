---
name: finance-ml
description: >
  ML-driven financial analysis patterns. Price prediction models, portfolio optimization,
  risk metrics, technical indicators, backtesting methodology, and financial data processing.
  Use when building trading strategies, analyzing financial data, or integrating with Aster DEX.
---

# Finance ML

Machine learning patterns for financial analysis and trading.

## how to use

- `/finance-ml`
  Apply financial ML patterns to the current analysis.

- `/finance-ml <task>`
  Guide for specific task: prediction, optimization, backtest, indicators, risk.

## when to apply

Reference these guidelines when:
- building price prediction models
- calculating technical indicators
- designing trading strategies
- optimizing portfolio allocation
- computing risk metrics
- backtesting strategies
- processing financial statements or bank data
- integrating ML signals with Aster DEX trading

## financial data sources

### FinanceDatabase (300k+ instruments)
```python
import financedatabase as fd

# Search instruments by category
equities = fd.Equities()
etfs = fd.ETFs()
funds = fd.Funds()
currencies = fd.Currencies()
cryptos = fd.Cryptos()

# Filter by sector, industry, country
tech_stocks = equities.search(sector="Technology", country="United States")

# Get ticker list for analysis
tickers = tech_stocks.index.tolist()
```

### Market Data Libraries
| Library | Data Type | Free Tier |
|---------|-----------|-----------|
| `yfinance` | Price, fundamentals, options | Yes |
| `financedatabase` | 300k+ instrument metadata | Yes |
| `alpha_vantage` | Price, forex, crypto | API key |
| `ccxt` | Crypto exchange data (100+ exchanges) | Yes |
| `pandas-datareader` | FRED, World Bank, OECD | Yes |

```python
import yfinance as yf

# Fetch OHLCV data
btc = yf.download("BTC-USD", start="2024-01-01", interval="1d")
# Columns: Open, High, Low, Close, Adj Close, Volume
```

## technical indicators

### Core Indicators
```python
import pandas as pd
import numpy as np

def sma(series: pd.Series, period: int) -> pd.Series:
    """Simple Moving Average."""
    return series.rolling(window=period).mean()

def ema(series: pd.Series, period: int) -> pd.Series:
    """Exponential Moving Average."""
    return series.ewm(span=period, adjust=False).mean()

def rsi(series: pd.Series, period: int = 14) -> pd.Series:
    """Relative Strength Index."""
    delta = series.diff()
    gain = delta.where(delta > 0, 0.0).rolling(window=period).mean()
    loss = (-delta.where(delta < 0, 0.0)).rolling(window=period).mean()
    rs = gain / loss
    return 100 - (100 / (1 + rs))

def macd(
    series: pd.Series,
    fast: int = 12,
    slow: int = 26,
    signal: int = 9,
) -> tuple[pd.Series, pd.Series, pd.Series]:
    """MACD indicator: (macd_line, signal_line, histogram)."""
    fast_ema = ema(series, fast)
    slow_ema = ema(series, slow)
    macd_line = fast_ema - slow_ema
    signal_line = ema(macd_line, signal)
    histogram = macd_line - signal_line
    return macd_line, signal_line, histogram

def bollinger_bands(
    series: pd.Series,
    period: int = 20,
    std_dev: float = 2.0,
) -> tuple[pd.Series, pd.Series, pd.Series]:
    """Bollinger Bands: (upper, middle, lower)."""
    middle = sma(series, period)
    std = series.rolling(window=period).std()
    upper = middle + (std_dev * std)
    lower = middle - (std_dev * std)
    return upper, middle, lower

def atr(
    high: pd.Series,
    low: pd.Series,
    close: pd.Series,
    period: int = 14,
) -> pd.Series:
    """Average True Range."""
    tr1 = high - low
    tr2 = (high - close.shift(1)).abs()
    tr3 = (low - close.shift(1)).abs()
    tr = pd.concat([tr1, tr2, tr3], axis=1).max(axis=1)
    return tr.rolling(window=period).mean()
```

## ML models for finance

### Model Selection Guide
| Model | Best For | Pros | Cons |
|-------|----------|------|------|
| LSTM | Sequence prediction | Captures temporal patterns | Slow training, overfitting risk |
| XGBoost | Feature-based prediction | Fast, handles missing data | No native sequence modeling |
| Random Forest | Classification signals | Interpretable, robust | Less precise than boosting |
| Transformer | Long-range dependencies | State-of-art performance | Data hungry, expensive |
| ARIMA/GARCH | Volatility forecasting | Statistical rigor | Linear assumptions |

### Feature Engineering
```python
def create_features(df: pd.DataFrame) -> pd.DataFrame:
    """Feature engineering for financial time series."""
    features = pd.DataFrame(index=df.index)

    # Price-based features
    features['returns_1d'] = df['Close'].pct_change(1)
    features['returns_5d'] = df['Close'].pct_change(5)
    features['returns_20d'] = df['Close'].pct_change(20)
    features['log_returns'] = np.log(df['Close'] / df['Close'].shift(1))

    # Volatility features
    features['volatility_20d'] = features['returns_1d'].rolling(20).std()
    features['volatility_60d'] = features['returns_1d'].rolling(60).std()

    # Technical indicators
    features['rsi_14'] = rsi(df['Close'], 14)
    features['sma_20'] = sma(df['Close'], 20)
    features['sma_50'] = sma(df['Close'], 50)
    features['sma_ratio'] = features['sma_20'] / features['sma_50']

    # Volume features
    features['volume_sma_20'] = sma(df['Volume'], 20)
    features['volume_ratio'] = df['Volume'] / features['volume_sma_20']

    # Price position
    features['distance_from_high'] = df['Close'] / df['High'].rolling(20).max() - 1
    features['distance_from_low'] = df['Close'] / df['Low'].rolling(20).min() - 1

    return features.dropna()
```

### LSTM Price Prediction Pattern
```python
import torch
import torch.nn as nn

class LSTMPredictor(nn.Module):
    def __init__(
        self,
        input_size: int,
        hidden_size: int = 64,
        num_layers: int = 2,
        dropout: float = 0.2,
    ) -> None:
        super().__init__()
        self.lstm = nn.LSTM(
            input_size, hidden_size, num_layers,
            batch_first=True, dropout=dropout,
        )
        self.fc = nn.Linear(hidden_size, 1)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        lstm_out, _ = self.lstm(x)
        return self.fc(lstm_out[:, -1, :])
```

## risk metrics

```python
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
    """Sortino Ratio (downside deviation only)."""
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
    elif method == "parametric":
        from scipy import stats
        z_score = stats.norm.ppf(1 - confidence)
        return returns.mean() + z_score * returns.std()
    raise ValueError(f"Unknown method: {method}")

def calmar_ratio(
    returns: pd.Series,
    periods_per_year: int = 252,
) -> float:
    """Calmar Ratio (annual return / max drawdown)."""
    annual_return = returns.mean() * periods_per_year
    mdd = abs(max_drawdown((1 + returns).cumprod()))
    return annual_return / mdd if mdd > 0 else 0.0
```

## portfolio optimization

### Mean-Variance (Markowitz)
```python
from scipy.optimize import minimize

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

    constraints = [{'type': 'eq', 'fun': lambda w: np.sum(w) - 1}]
    bounds = [(0, 1) for _ in range(n_assets)]
    initial = np.array([1/n_assets] * n_assets)

    result = minimize(neg_sharpe, initial, method='SLSQP',
                      bounds=bounds, constraints=constraints)

    optimal_weights = result.x
    return {
        'weights': dict(zip(returns.columns, optimal_weights)),
        'expected_return': float(np.dot(optimal_weights, mean_returns)),
        'volatility': float(np.sqrt(np.dot(optimal_weights.T,
                                            np.dot(cov_matrix, optimal_weights)))),
        'sharpe': float(-result.fun),
    }
```

## backtesting methodology

### Common Pitfalls
| Pitfall | Description | Prevention |
|---------|-------------|------------|
| Look-ahead bias | Using future data in decisions | Strict train/test split, walk-forward |
| Survivorship bias | Only testing on survivors | Use point-in-time data |
| Overfitting | Model memorizes noise | Cross-validation, out-of-sample test |
| Transaction costs | Ignoring fees and slippage | Include realistic cost model |
| Data snooping | Testing too many strategies | Bonferroni correction, holdout set |

### Walk-Forward Validation
```python
def walk_forward_backtest(
    data: pd.DataFrame,
    train_window: int = 252,
    test_window: int = 21,
    strategy_fn: callable = None,
) -> pd.Series:
    """Walk-forward out-of-sample backtest."""
    results = []
    for start in range(0, len(data) - train_window - test_window, test_window):
        train = data.iloc[start:start + train_window]
        test = data.iloc[start + train_window:start + train_window + test_window]

        model = strategy_fn(train)
        predictions = model.predict(test)
        results.append(predictions)

    return pd.concat(results)
```

## aster DEX integration

### ML-Informed Trading Workflow
```
1. Fetch market data: get_klines(symbol, interval="1h", limit=500)
2. Calculate features: technical indicators + ML predictions
3. Generate signal: BUY / SELL / HOLD with confidence score
4. Risk check:
   - Position size via Kelly criterion or fixed fractional
   - Check current positions: get_positions()
   - Check available balance: get_balance()
5. Present to user: signal, confidence, position size, risk metrics
6. User confirmation (MANDATORY - Rule 21 of Security Playbook)
7. Execute: create_order(symbol, side, type, quantity, price)
8. Monitor: track position with get_positions()
```

### Position Sizing
```python
def kelly_criterion(
    win_rate: float,
    avg_win: float,
    avg_loss: float,
    fraction: float = 0.25,  # Use fractional Kelly for safety
) -> float:
    """Kelly criterion for position sizing."""
    kelly = (win_rate * avg_win - (1 - win_rate) * avg_loss) / avg_win
    return max(0, kelly * fraction)  # Never go negative
```

## cross-references

- **aster-trading** skill: MCP tools for Aster DEX (44 tools)
- **data-analyst** agent: Statistical analysis and visualization
- **SECURITY_PLAYBOOK.md** Rules 21-25: DeFi trading security
- **xlsx** skill: Spreadsheet output for reports
- **FINANCE_ML_STACK.md**: Comprehensive reference doc
