import pandas as pd
from collections import defaultdict, Counter
import itertools


df = pd.read_csv("data/after_algo2_500_100_2.csv")

df = df[["author", "subreddit"]]


d = defaultdict(list)

for index, row in df.iterrows():
	d[row[0]].append(row[1])

a = [list(itertools.combinations(d[x], 2)) for x in d.keys() if x != 'AutoModerator']

b = [item for sublist in a for item in sublist]

counted = Counter(tuple(sorted(entry)) for entry in b)

c = [(key[0], key[1], counted[key]) for key in counted]

df = pd.DataFrame(c,columns=["subreddit1", "subreddit2", "n_links"])

df.to_csv("data/after_algo2_translated.csv",index=False,header=["subreddit1", "subreddit2", "n_links"])


