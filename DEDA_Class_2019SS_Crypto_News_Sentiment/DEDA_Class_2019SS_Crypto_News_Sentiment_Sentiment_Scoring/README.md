[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **DEDA_Class_2019SS_Crypto_News_Sentiment_Sentiment_Scoring** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of Quantlet: 'DEDA_Class_2019SS_Crypto_News_Sentiment_Sentiment_Scoring'

Published in: DEDA_Class_2019SS

Description:  'Sentiment scoring tool which takes the output of the news source
              scraping tool and applies to them the unsupervised VADER and TextBlob
              sentiment methods.'

Keywords: Sentiment Analysis, VADER, TextBlob, Cryptocurrency

Author: Alex Truesdale

Submitted: Wed. July 31 2019 by Alex Truesdale

Datafiles:  'Input files:
            - bbc_bitcoin.csv,
            - cnn_bitcoin.csv,
            - nyt_bitcoin.csv,
            - reuters_bitcoin.csv,

            Output files:
            - bbc_bitcoin_scored.csv,
            - cnn_bitcoin_scored.csv,
            - nyt_bitcoin_scored.csv,
            - reuters_bitcoin_scored.csv'

See also:  '1) plots/*.png
           2) DEDA_Class_2019SS_Crypto_News_Sentiment_Scraping_Tool'

```

### PYTHON Code
```python

"""Main module for sentiment analysis notebooks."""

import sys
sys.path.append('../')

import requirements as req
package_installer = req.PackageInstaller()
package_installer.module_check_install()

from sentiment_scorer import SentimentScorer

def main():
    """Main function for sentiment scoring tools."""

    scorer = SentimentScorer()

    scorer.bbc_frame = scorer.scorer_handler(scorer.bbc_frame, 'BBC')
    scorer.cnn_frame = scorer.scorer_handler(scorer.cnn_frame, 'CNN')
    scorer.nyt_frame = scorer.scorer_handler(scorer.nyt_frame, 'NYT')
    scorer.reuters_frame = scorer.scorer_handler(scorer.reuters_frame, 'Reuters')

    scorer.save_frames()

if __name__ == '__main__':
    main()

```

automatically created on 2019-08-02