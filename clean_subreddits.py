import re
import csv



defaults = set(['politics', 'WTF', 'Celebs', 'AdviceAnimals', 'Eyebleach'])
def clean_defaults(defaults):
	with open( 'default_sub.txt', 'r' ) as f:
		with open( 'defaults.txt', 'w' ) as out:
			for line in f:
				d = re.split('/' , line)[2]
				out.write( d )
				out.write('\n')
				defaults.add(d)


_f = 'top_t_d_2000_500_2.csv'
new_filename = 'top_t_d_2000_500_no_def_subred.csv'
def remove_rows_csv( file, key_words, colnum, new_filename ):
	with open(new_filename, 'wb') as newcsv:
		headers = [ "author", "subreddit", "total_score", "n_posts", "rn" ]
		_csv = csv.writer(newcsv, delimiter=',')
		_csv.writerow( headers )
		with open( _f, 'rb' ) as csvfile:
			reddit_users = csv.reader( csvfile, delimiter=',')

			for row in reddit_users:
				if row[colnum] not in key_words:
					_csv.writerow( row )


clean_defaults(defaults)
remove_rows_csv( _f, defaults, 1, new_filename )

