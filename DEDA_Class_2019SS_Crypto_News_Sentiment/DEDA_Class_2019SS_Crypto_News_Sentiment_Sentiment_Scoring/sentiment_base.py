"""Scraper base module containing general infrastructure methods."""

import pandas as pd
import time

def file_reader(source):
    """Source data .csv file reader."""

    frame = pd.read_csv(f'../data/scraped/{source}_bitcoin.csv')
    frame = frame.drop(['Unnamed: 0', 'Unnamed: 0.1'], axis=1)
    return frame

def story_filter(frame):
    """Remove stories with less than 5 sentences."""

    frame_length = len(frame)
    print('Removing stories with less than 5 sentences.. \n')
    print(f'{frame_length} rows in data frame. \n')

    stories = list(frame['content'])
    stories_sentences = [story.split('. ') for story in stories]

    for i, sentences in enumerate(stories_sentences):
        if len(sentences) < 5:
            print(f'Removing row {i}..')
            time.sleep(.2)
            frame = frame.drop([i])

    new_length = len(frame)
    difference = new_length - frame_length
    print(f'{abs(difference)} rows removed from data frame. \n')

    frame = frame.reset_index().drop(['index'], axis=1)
    return frame
