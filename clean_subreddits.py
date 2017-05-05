import re
import csv



defaults = set(['politics', 'WTF', 'Celebs', 'AdviceAnimals', 'Eyebleach', 'The_Donald'])
def clean_defaults(defaults):
	with open( 'default_sub.txt', 'r' ) as f:
		with open( 'defaults.txt', 'w' ) as out:
			for line in f:
				d = re.split('/' , line)[2]
				out.write( d )
				out.write('\n')
				defaults.add(d)
	return defaults



'''
	Note: I switch around the indicies when I write to file to make sure the
	author and aubreddit columns are next to eachother
'''
_f = 'top_2000_500_with_t_d_scores.csv'
new_filename = 'wtf.csv' #'2016_17_t_d_scores_no_def_subred.csv'
def remove_rows_csv( file, key_words, colnum, new_filename ):
	with open(new_filename, 'wb') as newcsv:
		#headers = [ "author", "subreddit", "total_score", "n_posts", "rn" ]
		_csv = csv.writer(newcsv, delimiter=',')
		#_csv.writerow( headers )
		with open( _f, 'rb' ) as csvfile:
			reddit_users = csv.reader( csvfile, delimiter=',')

			for row in reddit_users:
				if row[colnum] not in key_words:
					#_csv.writerow( row )
					_csv.writerow( [row[0], 'r/'+row[2], row[1], row[3], row[4], row[5] ] )


defaults = clean_defaults(defaults)
remove_rows_csv( _f, defaults, 2, new_filename )

