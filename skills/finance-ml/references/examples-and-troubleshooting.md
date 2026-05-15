# Examples And Troubleshooting

Purpose: worked examples, anti-patterns, and diagnostic checks for finance ML tasks.

## Worked Example: Direction Classifier

1. Define target: next-5-bar return greater than a threshold.
2. Build features: rolling returns, volatility, RSI, moving-average ratios, and volume ratios.
3. Split chronologically into train, validation, and test.
4. Train a logistic baseline and a tree model.
5. Convert predictions to positions only after thresholding and costs.
6. Backtest with fees, slippage, and max position limits.
7. Report predictive metrics, return metrics, drawdown, turnover, and exposure.

Minimal signal package:

```text
Asset: <symbol>
Horizon: 5 bars
Signal: BUY / SELL / HOLD
Confidence: <model-score>
Position proposal: <size-and-risk-rule>
Required evidence: data range, split, benchmark, fees, slippage, risk metrics
Approval: required before live order action
```

## Worked Example: Portfolio Allocation

1. Estimate returns and covariance from the training window.
2. Apply constraints: long-only, max weight, liquidity, and sector caps.
3. Optimize weights.
4. Rebalance on a fixed schedule.
5. Compare against equal-weight and market benchmarks.
6. Report turnover, realized volatility, drawdown, and concentration.

## Troubleshooting

If performance looks too good:

- Check target leakage from forward returns, future corporate actions, or full-sample scalers.
- Check whether train and test rows overlap through rolling windows.
- Confirm the strategy includes costs and slippage.
- Confirm the asset universe includes inactive assets when testing historical selection.

If live or paper performance diverges:

- Compare live data timestamps with backtest timestamps.
- Check order fill assumptions.
- Check latency, spread, and missing bars.
- Compare feature distributions between train and live periods.

If model metrics are good but returns are poor:

- Inspect thresholding and position sizing.
- Check turnover and fees.
- Evaluate calibration and class imbalance.
- Compare long-only, short-only, and market-neutral variants.

If risk metrics are unstable:

- Split by market regime.
- Recompute after removing extreme outliers and report both versions.
- Run parameter sensitivity.
- Use longer windows or reduce model complexity.

## Anti-Patterns

- Random row splits for time-series trading tasks.
- Training on adjusted data while trading on unadjusted live prices without reconciliation.
- Reporting accuracy without returns, costs, drawdown, or turnover.
- Treating backtest profit as deployable evidence.
- Using high leverage because backtest drawdown is low.
- Executing a DEX order from a model signal without explicit approval.
