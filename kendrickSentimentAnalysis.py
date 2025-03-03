#01. Data Collection

import lyricsgenius
import pandas as pd
import time

# Genius API Access Token
ACCESS_TOKEN = 'YJlwwiYmME_H9GMFYAeURmGIZhYycdL6T9Vwlr2YfCBOCm-ij6wsV975087EiD' # your API Access Token

# Initialize Genius API
genius = lyricsgenius.Genius(ACCESS_TOKEN)

# Configure timeout and retries
genius.timeout = 30  # Increase timeout to 30 seconds
genius.retries = 3   # Retry up to 3 times if request fails
genius.verbose = False  # Suppress verbose logging

# Function to collect lyrics directly from Genius API with retry logic
def collect_lyrics(artist_name, num_songs=20, max_retries=3):
    attempt = 0
    while attempt < max_retries:
        try:
            artist = genius.search_artist(artist_name, max_songs=num_songs, sort="popularity")
            song_data = []
            for song in artist.songs:
                song_data.append({
                    'Song Title': song.title,
                    'Artist': artist.name,
                    'Lyrics': song.lyrics if song.lyrics else "Lyrics not found"
                })
            return pd.DataFrame(song_data)
        except Exception as e:
            attempt += 1
            print(f"Attempt {attempt} failed. Error: {e}")
            if attempt < max_retries:
                wait_time = 2 ** attempt  # Exponentially increasing delay (e.g., 2, 4, 8 seconds)
                print(f"Retrying in {wait_time} seconds...")
                time.sleep(wait_time)
            else:
                print("Max retries reached. Could not fetch data.")
                return pd.DataFrame()  # Return empty DataFrame after max retries

# Run the function
kendrick_songs_df = collect_lyrics('Kendrick Lamar', num_songs=20)

# Save to CSV if data was successfully collected
if not kendrick_songs_df.empty:
    kendrick_songs_df.to_csv('kendrick_lamar_sentiment analysis.csv', index=False)
    print(kendrick_songs_df)
else:
    print("No data was fetched.")

#02. Data Cleaning


