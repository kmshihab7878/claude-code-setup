# Models And Selection

Purpose: detailed model catalog and finance-specific selection guidance.

## Model Catalog

| Model | Best For | Pros | Cons |
|-------|----------|------|------|
| Naive baseline | Sanity checks | Hard to beat honestly | Not predictive |
| Linear or logistic model | Interpretable factor signals | Simple and auditable | Misses nonlinear effects |
| ARIMA/GARCH | Price or volatility forecasting | Statistical clarity | Linear assumptions |
| Random Forest | Classification signals | Stable, interpretable enough | Can lag boosting |
| XGBoost | Feature-based prediction | Fast and strong on tabular data | Needs careful validation |
| LSTM | Sequence prediction | Captures temporal patterns | Overfitting risk and slower training |
| Transformer | Long-range dependencies | Strong on high-volume sequences | Data hungry and costly |
| Portfolio optimizer | Allocation | Directly maps to weights | Sensitive to return and covariance estimates |

## Selection Rules

- Start with a naive baseline and a simple statistical or tree model.
- Use tabular models when features are precomputed indicators, fundamentals, or factors.
- Use sequence models when raw sequence shape matters and data volume is sufficient.
- Use volatility models when the target is risk rather than direction.
- Use ranking models when the output is relative asset ordering.
- Use allocation methods only after expected returns and covariance estimates are stress tested.
- Reject models that only win before transaction costs.

## LSTM Price Prediction Pattern

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
            input_size,
            hidden_size,
            num_layers,
            batch_first=True,
            dropout=dropout,
        )
        self.fc = nn.Linear(hidden_size, 1)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        lstm_out, _ = self.lstm(x)
        return self.fc(lstm_out[:, -1, :])
```

## Interpretation Checks

- Compare feature importance against domain expectations.
- Check whether top features are timestamp or target leaks.
- Evaluate by market regime, not only by aggregate score.
- Compare predictions against simple momentum, mean-reversion, and buy-and-hold baselines.
- Inspect turnover and exposure created by the model, not only prediction metrics.
