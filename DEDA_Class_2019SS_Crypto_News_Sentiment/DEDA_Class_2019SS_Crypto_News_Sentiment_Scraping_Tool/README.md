[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **DEDA_Class_2019SS_Crypto_News_Sentiment_Scraping_Tool** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of Quantlet: 'DEDA_Class_2019SS_Crypto_News_Sentiment_Scraping_Tool'

Published in: DEDA_Class_2019SS

Description:  'Interactive, terminal based scraping tool built to collect news story
              text from the New York Times, BBC, CNN, and Reuters. The user chooses
              the desired news source and enters 1-3 search terms. Resulting publications
              are saved to a .csv file for further processing needs of the user.'

Keywords: Scraping, Text Analysis, Selenium, Cryptocurrency

Author: Alex Truesdale

Submitted: Wed. July 31 2019 by Alex Truesdale

Datafiles:  '- bbc_bitcoin.csv
            - cnn_bitcoin.csv
            - nyt_bitcoin.csv
            - reuters_bitcoin.csv'

See also:  '1) scraper_base.py
           2) scraper_bbc.py
           3) scraper_cnn.py
           4) scraper_nyt.py
           5) scraper_reuters.py
           6) source_selector.py'

```

### PYTHON Code
```python

"""Main module for scraping suite."""

import sys
sys.path.append('../')

import requirements as req
package_installer = req.PackageInstaller()
package_installer.module_check_install()

from pick import pick
from source_selector import source_selector

def main():
    """Main function for news source data scraping tool."""

    title = 'Please select a news source from which to gather text data (press ENTER to select indicated option): '
    options = ['BBC', 'NYT', 'Reuters', 'CNN']
    selected_source = pick(options, title, multi_select=False, min_selection_count=1)[0].lower()
    source_data, query = source_selector(selected_source)

    source_data.to_csv(f'../data/scraped/{selected_source}_{query}.csv')

if __name__ == '__main__':
    main()

```

automatically created on 2019-08-02