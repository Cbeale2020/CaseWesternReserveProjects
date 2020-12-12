import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from matplotlib.patches import Rectangle


def macd(series, a=12, b=26, c=9):
    # compute the exponential moving averages for a and b
    moving_averages = []
    for window_size in [a, b]:
        # first compute simple moving average
        moving_average = series.rolling(window_size).mean()
        alpha = 2 / (window_size + 1)
        moving_average.iloc[window_size:] = series.iloc[window_size:]
        moving_average = moving_average.ewm(alpha=alpha, adjust=False).mean()
        moving_average.rename(f'{series.name} EMA {window_size}', inplace=True)
        moving_averages.append(moving_average)
    # compute macd on the exponential moving averages
    macd = moving_averages[-2].subtract(moving_averages[-1])
    macd.rename(f'{series.name} MACD', inplace=True)
    # compute sell signal on macd, c-size exponential moving average
    signal = macd[~macd.isna()].rolling(c).mean()
    signal.iloc[c:] = macd[~macd.isna()].iloc[c:] 
    alpha = 2 / (c + 1)
    signal = signal.ewm(alpha=alpha, adjust=False).mean()
    signal.rename(f'{series.name} MACD Signal', inplace=True)
    return pd.concat(moving_averages + [macd] + [signal], axis='columns')


def simple_moving_average(data, window_size):
    if not isinstance(data, (pd.DataFrame, pd.Series)):
        raise ValueError('data must be pandas.DataFrame or pandas.Series')
    return data.rolling(window_size).mean()


def candlestick(axes, stock_data, bar_width=0.51):
    data_columns = {'Close', 'Open', 'High', 'Low'}
    if not data_columns.issubset(set(stock_data.columns)):
        raise ValueError(f'stock_data must have {data_columns} in columns')
    for k, row in enumerate(stock_data.iterrows()):
        record = row[1]
        delta = record['Close'] - record['Open']
        if delta > 0:
            color = 'g'
        else:
            color = 'r'
        axes.plot([k, k], [record['Low'], record['High']], color='k', zorder=1, linewidth=1)
        rect_x = k - np.round((bar_width / 2), 2)
        rect_y = min([record['Open'], record['Close']])
        height = np.abs(record['Open'] - record['Close'])
        rect = Rectangle(xy=(rect_x, rect_y), width=bar_width, height=height, color=color, zorder=3, alpha=0.5)
        axes.add_patch(rect)
    return axes


def refine_crossing_candidates(values, signs, indices):
    refined_indices = []
    for idx in indices:
        sign = signs[idx]
        true_idx = min([idx, idx - 1], key=lambda i: np.abs(values[i]))
        refined_indices.append((true_idx, sign))
    return np.array(refined_indices)


def zero_crossing(series, refine=False):
    if not isinstance(series, pd.Series):
        raise ValueError(f'expected pd.Series, but received {type(series)}')
    index = series.index
    with np.errstate(invalid='ignore'):  # numpy doesnt like taking the sign of a nan
        signs = np.r_[[np.nan], np.diff(np.sign(series))] / 2.  # prepend a nan to keep length the same
    idx = np.greater(np.abs(signs), 0., where=np.isfinite(signs)) & np.isfinite(signs)
    crossing_idx = np.where(idx)[0]
    # now, we have to refine our estimates since this always gives the location beyond the crossing 
    # note that this can cause repeated crossovers to disappear
    if refine:
        crossing_info = refine_crossing_candidates(series.to_numpy(), signs, crossing_idx)
    else:
        crossing_info = np.column_stack([crossing_idx, signs[crossing_idx]])
    # we might not have any crossings
    if len(crossing_info) > 0:
        crossing_idx = crossing_info[:, 0].astype(int)
        signs = crossing_info[:, 1]
        crossings = np.zeros(len(series), dtype=int)
        crossings[crossing_idx] = signs
    else:
        crossings = np.zeros(len(series), dtype=int)
    return pd.Series(crossings, index=index)


def macd_indicators(data, macd_column='Close MACD', signal_column='Close MACD Signal'):
    # compute macd-signal line crossovers
    signal_line_crossover = zero_crossing(data[signal_column] - data[macd_column])
    signal_line_crossover.rename(macd_column + ' Signal Line Crossover', inplace=True)
    # compute macd-zero crossing
    macd_crossover = zero_crossing(data[macd_column])
    macd_crossover.rename(macd_column + ' Zero Crossover', inplace=True)
    return pd.concat([data, macd_crossover, signal_line_crossover], axis='columns')


if __name__ == '__main__':
    import yfinance as yf
    from matplotlib.ticker import FuncFormatter, MaxNLocator

    stock_data = yf.download('AMD', start='2020-04-01', end='2020-08-28')

    macd_data = macd(stock_data['Close'])
    stock_data = pd.concat([stock_data, macd_data], axis='columns')
    stock_data = macd_indicators(stock_data)
    print(stock_data.head())

    fig, ax = plt.subplots()

    ax.plot(np.arange(len(stock_data)), stock_data['Close MACD'], '-o')
    ax.plot(np.arange(len(stock_data)), stock_data['Close MACD Signal'], '-o')

    sig_line_loc = np.where(stock_data['Close MACD Signal Line Crossover'].to_numpy() != 0)[0]
    macd_line_loc = np.where(stock_data['Close MACD Zero Crossover'].to_numpy() != 0)[0]

    ax.vlines(x=sig_line_loc, ymin=0, ymax=5, color='k')
    ax.vlines(x=macd_line_loc, ymin=0, ymax=5, color='r')

    plt.show()
