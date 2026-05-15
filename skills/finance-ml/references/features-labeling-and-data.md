# Features, Labeling, And Data

Purpose: reference for market data preparation, technical indicators, feature engineering, and label alignment.

## Data Preparation Rules

- Sort data by timestamp before rolling calculations.
- Normalize timezone and session boundaries.
- Adjust prices for splits and dividends when the strategy depends on total return.
- Keep delisted assets when testing historical universes.
- Fit scalers and imputers only on training windows.
- Build labels after feature calculation to avoid future data leakage.
- Store the exact data source, retrieval time, symbol mapping, and date range.

## Technical Indicators

```python
import numpy as np
import pandas as pd

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

## Feature Engineering

```python
def create_features(df: pd.DataFrame) -> pd.DataFrame:
    """Feature engineering for financial time series."""
    features = pd.DataFrame(index=df.index)

    features["returns_1d"] = df["Close"].pct_change(1)
    features["returns_5d"] = df["Close"].pct_change(5)
    features["returns_20d"] = df["Close"].pct_change(20)
    features["log_returns"] = np.log(df["Close"] / df["Close"].shift(1))

    features["volatility_20d"] = features["returns_1d"].rolling(20).std()
    features["volatility_60d"] = features["returns_1d"].rolling(60).std()

    features["rsi_14"] = rsi(df["Close"], 14)
    features["sma_20"] = sma(df["Close"], 20)
    features["sma_50"] = sma(df["Close"], 50)
    features["sma_ratio"] = features["sma_20"] / features["sma_50"]

    features["volume_sma_20"] = sma(df["Volume"], 20)
    features["volume_ratio"] = df["Volume"] / features["volume_sma_20"]

    features["distance_from_high"] = df["Close"] / df["High"].rolling(20).max() - 1
    features["distance_from_low"] = df["Close"] / df["Low"].rolling(20).min() - 1

    return features.dropna()
```

## Labeling Methods

- Direction label: `future_return > threshold`.
- Regression label: forward return over a fixed horizon.
- Volatility label: future realized volatility.
- Drawdown label: whether drawdown breaches a threshold.
- Ranking label: cross-sectional future return rank.

Example:

```python
def make_forward_return_label(close: pd.Series, horizon: int = 5) -> pd.Series:
    """Forward return label aligned to the decision timestamp."""
    return close.shift(-horizon) / close - 1
```

Keep feature rows whose label is unavailable out of training and evaluation.
