---
layout: post
title:  "Let's talk about readable hashes"
category: CS
tags: [software, projects]
---

Hash functions are great - for computers. But how often do you find yourself actually verifying checksums by hand or eye? Wouldn't it be nice if we could take a blob of binary, like an RSA key or a piece of software, and then not just hash it into something illegible like `d732fee6462de7f04f9432f1bb3925f57554db1d8c8d6f3138eea70e5787c7ae`, but make an English phrase that's memorable enough for a human to remember?

## Yeah, this idea isn't new

Here's a bunch of things other people have already done to solve this exact problem:

1. [BIP39](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki) is a popular algorithm used by Bitcoin wallets to generate 12 or 24-word mnemonics from a prefix of the SHA256 hash of your private key. It has been widely adapted, with ports to over 10 different languages listed on the project page alone.
2. [mnemonicode](https://github.com/singpolyma/mnemonicode) by Oren Tirosh and Stephen Paul Weber is a general invertible algorithm for converting binary sequences into short, clear, easy-to-pronounce words and back. It uses a carefully curated wordlist of just 1,626 words and has similarly been ported to quite a few different languages.
3. [RFC 1751](https://tools.ietf.org/html/rfc1751) is likewise intended to be easy to read aloud, with a wordlist of 2048 short words with no more than 4 letters each.
4. [fpgaminer/hash-phrase](https://github.com/fpgaminer/hash-phrase) uses a prefix of the PBKDF2 SHA256 of a bytestring to get a 5-word phrase from a longer wordlist of 10,000.

You can also find a comparison of many of these algorithms [here](https://gist.github.com/raineorshine/8d67049c0aaaa082614e417660462fda), with sample outputs.

## My approach

I had my own idea for how to make a human-readable hash, and I'd like to share it here. My approach has a relatively long wordlist, making for somewhat weirder, more memorable phrases that tend to be more difficult to dictate. It's also an invertible approach where you can reconstruct the hash from the phrase.

### Setup

I started with a list of the 100,000 most common words on Project Gutenberg, as compiled by h3xx on GitHub [here](https://gist.github.com/h3xx/1976236). The downside of starting with such a long wordlist is that it isn't very well-curated, so there's a decent amount of junk and profanity and the like. Personally though, I like long wordlists for their ability to create phrases that are more memorable, especially in the long-term. For now, let's pull out the 65,536 most common words[^1] and hold on to them.

```python
with open('wiki-100k.txt', 'r') as f:
    lines = [l.strip() for l in f.readlines() if not l.startswith('#!comment')]
# omitted: filtering out one-letter words, words with punctuation, etc.
limit = 1 << 16
lines = lines[:limit]
lines.sort()
with open('common_dict.txt', 'w') as f:
    f.write('\n'.join(lines))
```

Let's also get ourselves a sample binary sequence to encode. How about a public key?

```python
import base64
with open('/home/krishna/.ssh/id_rsa.pub') as f:
    pubkey = f.read()
key = pubkey.strip().split()[1] # get rid of extra stuff
bkey = base64.b64decode(key)
```

Now for the fun part.

### Main algorithm

The actual algorithm is pretty straightforward. You take the SHA256 of your bytestring as a sequence of 32 bytes, then reinterpret it as a sequence of 16 16-bit unsigned integers[^2]. You can then use those integers to index directly into our wordlist. Since we have 2^16 words, we have exactly one word for every potential index, giving us a nice invertible function to generate phrases with.

```python
import hashlib
digest = hashlib.sha256(bkey).digest()
words = []
for i in range(16):
    block = digest[i:i+2]
    idx = int.from_bytes(block, byteorder='little')
    words.append(lines[idx])
```

As an example, here's the generated phrase for my pubkey, without any kind of capitalization normalization:

```
Magistrate Armenian Miene petticoats greens Lulu voy emperors Goths Rhin prestige Delft support Rod affliction whilst
```

Right off the bat, words like "magistrate", "petticoats", "emperors", and "prestige" make this a cinch to remember in the long-term. Even if I don't know the exact phrase, the general impression of regal imagery means that I'll never mistake this for another arbitrary phrase.

In practice, I really think this is the sweetspot for invertible human-readable mnemonics for hashes. Phrases longer than 16 words are exhausting to type out while offering no additional purchase for your memory, and a wordlist with more than 16 bits of entropy starts to look very weird, being mostly comprised of rare words that are hard to remember or recognize at all.

### The future

All of the code in this post has been in Python so far, but I've also written a reference version of this algorithm in Rust, which you can find [on my GitHub](https://github.com/krishnachittur/readable-hashes/tree/master). It's still not super polished, but it's pretty fast and it works. I hope to clean it up and add to it in the coming days.

I did have one alternative idea for generating these phrases in a non-invertible way, which involved using a [GAN](https://en.wikipedia.org/wiki/Generative_adversarial_network) to generate memorable sentences or images and feeding in the SHA256 hash as an input to the trained generator. I may explore this idea more in the future.

My ideal future is one where readable hashes are used everywhere, not just as checksums to verify the integrity of downloaded files, but as a way to confirm the identity of friends and family. Imagine signing up for an account on a new chat application and receiving a friend request from someone you think you know. Wouldn't it be nice if a brief blurb showed up under their request that only their public key could have generated? Alas, the first challenge is popularizing end-to-end encryption enough for it to be the norm for one person to reuse the same keys across multiple applications. Until then, this dream will have to wait.

### Footnotes

[^1]: That is, 2^16, for reasons that will be obvious later.
[^2]: We'll use little-endian here, since that's what every major OS uses.