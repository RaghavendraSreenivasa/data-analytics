use kendrick_db;

select * from kendrick_Lyrics;

SET SQL_SAFE_UPDATES = 0;

-- Step 1: Remove URLs
UPDATE kendrick_lyrics
SET lyrics = REGEXP_REPLACE(lyrics, 'http[s]?://[a-zA-Z0-9./?=_-]+', '');

-- Step 2: Remove unwanted characters (special characters, punctuation, etc.)
UPDATE kendrick_lyrics
SET lyrics = REGEXP_REPLACE(lyrics, '[^a-zA-Z0-9\s.,!?\'\"()-]', '');

-- Step 3: Remove multiple spaces and trim extra whitespace
UPDATE kendrick_lyrics
SET lyrics = REGEXP_REPLACE(lyrics, '\\s+', ' ');  -- Replace multiple spaces with a single space
UPDATE kendrick_lyrics
SET lyrics = TRIM(lyrics);  -- Remove leading and trailing spaces

-- Step 4: Remove sections like 'Intro', 'Chorus', 'Verse', 'Outro', etc.
UPDATE kendrick_lyrics
SET lyrics = REGEXP_REPLACE(lyrics, '(Intro|Outro|Verse|Chorus|Bridge|Refrain)', '');


-- Step 5: Optionally, you can clean the text further by replacing other undesired patterns.


SET SQL_SAFE_UPDATES = 0;
UPDATE kendrick_lyrics
SET lyrics = TRIM(
                REGEXP_REPLACE(
                    REGEXP_REPLACE(
                        REGEXP_REPLACE(lyrics, '^(Intro|Chorus|Verse|Bridge|Refrain)[\s:]*', ''),
                        '^[^a-zA-Z0-9]+', ''
                    ),
                    '^[\s]*', ''  -- This removes any leading spaces after the unwanted words are removed
                )
            )
WHERE id IS NOT NULL;

SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;
UPDATE kendrick_lyrics
SET lyrics = TRIM(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        REPLACE(
                                            REPLACE(
                                                REPLACE(lyrics, 'yawk', ''),
                                                'bro', ''
                                            ),
                                            'nigga', ''
                                        ),
                                        'this', ''
                                    ),
                                    'song', ''
                                ),
                                'you', ''
                            ),
                            'me', ''
                        ),
                        'her', ''
                    ),
                    'he', ''
            ))
WHERE id IS NOT NULL;


SET SQL_SAFE_UPDATES = 0;

SELECT * FROM kendrick_lyrics ;
