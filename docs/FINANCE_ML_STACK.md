# Finance ML Stack Reference

> Machine learning toolkit for financial analysis and trading
> Covers: data sources, models, feature engineering, backtesting, risk management
> Compiled: 2026-03-15

---

## Data Sources & Libraries

### Financial Data Libraries

| Library | Data | Install | Free |
|---------|------|---------|------|
| `financedatabase` | 300k+ instruments (equities, ETFs, funds, crypto, currencies) | `pip install financedatabase` | Yes |
| `yfinance` | OHLCV, fundamentals, options, dividends | `pip install yfinance` | Yes |
| `ccxt` | 100+ crypto exchange APIs unified | `pip install ccxt` | Yes |
| `pandas-datareader` | FRED, World Bank, OECD, Stooq | `pip install pandas-datareader` | Yes |
| `alpha_vantage` | Stocks, forex, crypto, technicals | `pip install alpha_vantage` | API key |
| `polygon-api-client` | US stocks, options, crypto (real-time) | `pip install polygon-api-client` | API key |
| `fredapi` | Federal Reserve economic data | `pip install fredapi` | API key |

### Aster DEX Integration
```python
# Use Aster MCP tools for live crypto data
# get_klines → OHLCV candles
# get_ticker → 24h stats
# get_order_book → depth data
# get_funding_rate → perpetual funding
```

### FinanceDatabase Usage
```python
import financedatabase as fd

# Browse by asset class
equities = fd.Equities()
cryptos = fd.Cryptos()

# Search with filters
tech = equities.search(sector="Technology", country="United States")
# Returns DataFrame with: name, currency, sector, industry, exchange, market_cap

# Get ticker symbols for downstream analysis
tickers = tech.index.tolist()[:20]  # Top 20 tech stocks
```

---

## Model Comparison Matrix

| Model | Financial Use | Accuracy | Speed | Interpretability | Data Needs |
|-------|-------------|----------|-------|-------------------|------------|
| **LSTM** | Price sequences, volatility | High | Slow | Low | Large |
| **GRU** | Faster sequence modeling | High | Medium | Low | Large |
| **Transformer** | Long-range patterns | Highest | Slow | Low | Very Large |
| **XGBoost** | Cross-sectional features | High | Fast | Medium | Medium |
| **Random Forest** | Signal classification | Medium | Fast | High | Small |
| **ARIMA** | Trend/seasonality | Medium | Fast | High | Small |
| **GARCH** | Volatility forecasting | High | Fast | High | Medium |
| **Prophet** | Time series with events | Medium | Fast | High | Small |
| **Logistic Reg** | Direction prediction | Low-Med | Fast | Highest | Small |
| **VAR** | Multi-asset modeling | Medium | Fast | High | Medium |

### When to Use What

| Scenario | Recommended Model | Why |
|----------|-------------------|-----|
| Predict next-day direction | XGBoost with technical features | Fast, handles many features well |
| Forecast volatility | GARCH(1,1) | Statistical foundation, interpretable |
| Multi-step price forecast | LSTM/Transformer | Captures sequential dependencies |
| Portfolio allocation | Mean-Variance + Black-Litterman | Well-established, reliable |
| Anomaly detection | Isolation Forest | Unsupervised, handles high-dim |
| Regime detection | Hidden Markov Model | Captures market state transitions |

---

## Feature Engineering for Financial Time Series

### Feature Categories

| Category | Features | Code Pattern |
|----------|----------|--------------|
| Returns | 1d, 5d, 20d, 60d returns; log returns | `df['Close'].pct_change(n)` |
| Volatility | Rolling std, ATR, Parkinson, Garman-Klass | `returns.rolling(n).std()` |
| Momentum | RSI, MACD, ROC, Williams %R | See finance-ml skill |
| Trend | SMA ratios, ADX, Aroon | `sma(close, 20) / sma(close, 50)` |
| Volume | OBV, VWAP, volume ratio, A/D line | `volume / volume.rolling(20).mean()` |
| Microstructure | Bid-ask spread, order imbalance | From order book data |
| Calendar | Day of week, month, quarter, holidays | `pd.Timestamp.dayofweek` |
| Cross-asset | SPY correlation, VIX level, DXY | `df['close'].rolling(20).corr(spy)` |
| Fundamental | P/E, P/B, EPS growth, dividend yield | From `yfinance` fundamentals |

### Feature Engineering Best Practices
1. **Normalize**: Z-score or min-max within rolling windows
2. **Lag**: Always use `shift(1)` to prevent look-ahead bias
3. **Stationarity**: Difference non-stationary series (ADF test)
4. **Feature selection**: SHAP values, mutual information, recursive elimination
5. **Multicollinearity**: Check VIF, drop redundant features

---

## Common Pitfalls in Financial ML

| Pitfall | Description | Prevention |
|---------|-------------|------------|
| **Look-ahead bias** | Using future data in features or labels | Strict `shift(1)`, walk-forward validation |
| **Survivorship bias** | Only testing on currently listed assets | Use point-in-time databases |
| **Overfitting** | Model memorizes noise | Regularization, simpler models, hold-out set |
| **Data snooping** | Testing too many strategies on same data | Bonferroni correction, family-wise error rate |
| **Transaction costs** | Ignoring fees, spread, slippage | Include realistic cost model (10-30 bps) |
| **Regime change** | Model trained on bull market fails in crash | Regime-aware models, shorter training windows |
| **Non-stationarity** | Statistical properties change over time | Rolling normalization, differencing |
| **Class imbalance** | More neutral days than trend days | SMOTE, class weights, threshold tuning |

---

## Risk Management Formulas

### Position Sizing

```python
# Kelly Criterion (fractional)
def kelly_size(win_rate: float, win_loss_ratio: float, fraction: float = 0.25) -> float:
    kelly = win_rate - (1 - win_rate) / win_loss_ratio
    return max(0, kelly * fraction)

# Fixed Fractional
def fixed_fractional(account_balance: float, risk_pct: float, stop_loss_distance: float) -> float:
    risk_amount = account_balance * risk_pct
    return risk_amount / stop_loss_distance

# Volatility-based (ATR)
def atr_position_size(account: float, risk_pct: float, atr: float, multiplier: float = 2.0) -> float:
    risk_amount = account * risk_pct
    return risk_amount / (atr * multiplier)
```

### Risk Metrics Reference

| Metric | Formula | Good Value |
|--------|---------|------------|
| Sharpe Ratio | (Rp - Rf) / σp × √252 | > 1.0 |
| Sortino Ratio | (Rp - Rf) / σd × √252 | > 1.5 |
| Max Drawdown | (Peak - Trough) / Peak | < -20% |
| Calmar Ratio | Annual Return / Max DD | > 1.0 |
| Win Rate | Wins / Total Trades | > 50% |
| Profit Factor | Gross Profit / Gross Loss | > 1.5 |
| VaR (95%) | 5th percentile of returns | Context-dependent |
| CVaR (95%) | Mean of returns below VaR | Context-dependent |

---

## Python Library Stack

```
# Core
pip install pandas numpy scipy

# Data
pip install yfinance financedatabase ccxt pandas-datareader

# ML
pip install scikit-learn xgboost lightgbm

# Deep Learning
pip install torch torchvision  # or tensorflow

# Technical Analysis
pip install ta  # or ta-lib (requires C library)
pip install pandas-ta  # pure Python alternative

# Backtesting
pip install backtrader  # or vectorbt, zipline-reloaded

# Visualization
pip install matplotlib seaborn plotly

# Statistics
pip install statsmodels arch  # for GARCH models
```

---

## Backtesting Best Practices

### Walk-Forward Methodology
```
|---Train---|--Test--|
     |---Train---|--Test--|
          |---Train---|--Test--|
```

### Realistic Cost Model
```python
@dataclass
class CostModel:
    commission_pct: float = 0.001  # 0.1% (10 bps)
    slippage_pct: float = 0.0005  # 0.05% (5 bps)
    funding_rate_8h: float = 0.0001  # 0.01% per 8h for perps

    def total_cost(self, trade_value: float, holding_hours: float = 0) -> float:
        entry_cost = trade_value * (self.commission_pct + self.slippage_pct)
        exit_cost = trade_value * (self.commission_pct + self.slippage_pct)
        funding_cost = trade_value * self.funding_rate_8h * (holding_hours / 8)
        return entry_cost + exit_cost + funding_cost
```

---

## Cross-References

- **finance-ml** skill: Technical indicators, ML models, risk metrics code
- **aster-trading** skill: 44 MCP tools for Aster DEX trading
- **data-analyst** agent: Statistical analysis and visualization
- **xlsx** skill: Spreadsheet output for financial reports
- **SECURITY_PLAYBOOK.md** Rules 21-25: DeFi trading security
