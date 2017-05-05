import csv
import networkx as nx
import matplotlib.pyplot as plt

G=nx.Graph()
user_nodes = set()
subreddit_nodes = set()

#extract nodes and edges from graph
node_edge_l = csv.reader(open("2016_17_no_def_subred.csv","rb"))
for row in node_edge_l: 
    if row[0] not in user_nodes:
        G.add_nodes_from(row[0], color = 'blue')
        user_nodes.add(row[0])
    if row[1] not in subreddit_nodes:
        G.add_nodes_from(row[1], color = 'red')
        subreddit_nodes.add(row[1])
    G.add_edge(row[0],row[1])

# Remove empty nodes
for n in G.nodes():
    if n == '':
        G.remove_node(n)
# color nodes according to their color attribute
color_map = []
for n in G.nodes():
    if n in user_nodes:
        color_map.append('blue')
    else:
        color_map.append('red')


#for n in G.nodes():
#    color_map.append(G.node[n]['color'])

nx.draw_networkx(G)#, node_color = color_map, with_labels = True, node_size = 500)

plt.savefig("path.png")

plt.show()
