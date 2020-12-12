import json
import os
import pandas as pd
import requests
import time
import warnings

from nltk.sentiment.vader import SentimentIntensityAnalyzer
from tqdm import tqdm


class NYTArticleClient:
    def __init__(self):
        self.base_url = 'https://api.nytimes.com/svc/search/v2/articlesearch.json'
        self.sleep = 7  # 10 requests per minute
        self.total_requests = 0  # 4000 per day
        self.daily_limit = 4000
        self.api_key = os.environ['NYT_API_KEY']
        self.base_params = {'api-key': self.api_key}

    def fetch(self, params):
        if self.total_requests >= self.daily_limit:
            warnings.warn(f'You are at or exceeding the daily request limit since instantiation for {self.__class__}')
        query_params = dict(**params, **self.base_params)
        response = requests.get(self.base_url, query_params).json()
        time.sleep(self.sleep)
        self.total_requests += 1
        return response


class ContextualNewsClient:
    def __init__(self):
        self.base_url = "https://contextualwebsearch-websearch-v1.p.rapidapi.com/api/Search/NewsSearchAPI"
        self.sleep = 0.25  # 5 reqs per second
        self.api_key = os.environ['X-RapidAPI-Key']
        self.headers = {
            'x-rapidapi-host': "contextualwebsearch-websearch-v1.p.rapidapi.com",
            'x-rapidapi-key': self.api_key
            }

    def fetch(self, params):
        r = requests.get(self.base_url, params=params, headers=self.headers).json()
        time.sleep(self.sleep)
        return r


def fetch_headlines_nyt(query_terms, start_date, end_date, pages=5):
    all_data = []
    client = NYTArticleClient()
    for query in tqdm(query_terms):
        headlines = []
        pub_dates = []
        for page in range(pages):
            params = {
                'q': query,
                'fq': 'news_desk: ("Business", "Financial")',
                'begin_date': start_date,
                'end_date': end_date,
                'page': str(page)
            }
            try:
                response = client.fetch(params)
                docs = response['response']['docs']
                headlines.extend([doc['abstract'] for doc in docs])
                pub_dates.extend([doc['pub_date'] for doc in docs])
                assert len(headlines) == len(pub_dates)
            except (KeyError, json.decoder.JSONDecodeError):
                print(f'Could not retrieve data for {query}')

        all_data.append({
                    query: {'headline': headlines, 'pub_date': pub_dates}
                })

    return all_data


def fetch_headlines_contextual(query_terms, start_date, end_date,  page_size=50, **search_kwargs):
    all_data = []
    client = ContextualNewsClient()
    start_date = f'{start_date[:4]}-{start_date[4:6]}-{start_date[-2:]}'
    end_date = f'{end_date[:4]}-{end_date[4:6]}-{end_date[-2:]}'
    for query in tqdm(query_terms):
        params = {
            'q': query,
            'pageSize': page_size,
            'fromPublishedDate': start_date,
            'toPublishedDate': end_date
        }
        try:
            response = client.fetch(params)
            docs = response['value']
            headlines = [doc['description'] for doc in docs]
            pub_dates = [doc['datePublished'] for doc in docs]
            assert len(headlines) == len(pub_dates)
            all_data.append(
                {query: {'headline': headlines, 'pub_date': pub_dates}}
            )
        except (KeyError, json.decoder.JSONDecodeError):
            print(f'Could not retrieve data for {query}')
            headlines = []
            pub_dates = []

        all_data.append(
                {query: {'headline': headlines, 'pub_date': pub_dates}}
            )
    
    return all_data


def compute_headline_sentiment(headline_df):
    vader = SentimentIntensityAnalyzer()
    # add new columns for sentiment scores, initialize with zeros
    headline_df[['vader_neg', 'vader_neu', 'vader_pos', 'vader_compound']] = 0. 
    for k, row in tqdm(enumerate(headline_df.iterrows())):
        headline = row[1]['headline']
        polarity = vader.polarity_scores(str(headline))
        headline_df.iloc[k, -4] = polarity['neg']
        headline_df.iloc[k, -3] = polarity['neu']
        headline_df.iloc[k, -2] = polarity['pos']
        headline_df.iloc[k, -1] = polarity['compound']
    return headline_df


if __name__ == '__main__':
    import random

    vader = SentimentIntensityAnalyzer()

    query_terms = ['Google']

    all_headline_data = fetch_headlines_nyt(query_terms, pages=1, start_date='20200801', end_date='20200831')

    data = []
    for group in all_headline_data:
        query_term = list(group.keys())[0]
        headlines = group[query_term]['headline']
        pub_dates = group[query_term]['pub_date']
        data.append(
            {'headline': headlines,
            'pub_date': pub_dates,
            'Symbol': len(headlines) * [query_term],
            'Source': len(headlines) * ['NYT']}
        )

    df = pd.DataFrame(data[0])

    print(compute_headline_sentiment(df))