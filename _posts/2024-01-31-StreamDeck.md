---
title: "Running Custom Scripts from a StreamDeck"
last_modified_at: 2024-01-31T16:00:00-07:00
---

Originally posted here: [Reddit post](https://www.reddit.com/r/StreamDeckSDK/comments/tpa3l3/stream_deck_running_custom_scripts/){:target="_blank"}

I have expanded on these findings and made working snippets I would use often with my StreamDeck which can be found on my GitHub [here](https://github.com/jasapple/deskScripts){:target="_blank"}.

---

I've been spending some time working with the Stream Deck and trying to use it to launch various scripts/interface with AWS.

I figured I'd share some of my discoveries.

#### Setup:
- macOS: 10.15.7
- Stream Deck version: 5.2.1
- Hardware: Stream Deck XL

I have been using the 'Open' System action to call various scripts. Here are some 'gotchas':
- Script must have a valid extension (.sh and .py have worked for me so far)
- Script must be executable (chmod +x myscript.sh)
- All arguments are sent to the command
- Unlike in a traditional shell (bash, zsh, sh) file redirection will NOT work
- Output using `foo.py` (contents below) to output to stdout, stderr, and to trigger a Traceback
```
/Users/jasapple/git/deckScripts/foo.py >> pypypyp.txt 2>&1
Hello World['/Users/jasapple/git/deckScripts/foo.py', '>>', 'pypypy.txt', '2>&1']
/Users/jasapple/git/deckScripts/foo.py
Hello World['/Users/jasapple/git/deckScripts/foo.py']
```
- The `$PATH`` var is extremely limited. I found it is better to just assume you have none and use the full command path.
```
$ which ls
/bin/ls
$ which python3
/usr/local/bin/python3
```
For debugging, I wanted to capture stdout and stderr. Since the Stream Deck doesn't have anyway to actually view this, I opted to output everything to a log file. I wrote the below script as a output redirect

```
#!/bin/bash

exec >> log.txt
exec 2>&1

#env #show the environment variables

/usr/local/bin/python3 myScript.py $@
```

The next adventure is to update the text on the Stream Deck based on system variables

Contents of 'foo.py'
```
#!/usr/bin/env python3

import sys

print("foobar")

with open("streamLog.txt","a") as f:
    f.write("Hello World")

    f.write(str(sys.argv) + "\n")

    print("can you hear me?")

    raise KeyError
```