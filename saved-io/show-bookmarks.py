import pandas as pd
import sys
import saved as config

try:
    rowlen = int(sys.argv[1])
except:
    rowlen = None

filepath = config.FILEPATH 

def view(rows=None):
    df = pd.read_csv(filepath,sep=',',lineterminator='\n')
    print(f"total links: {len(df)}")
    rowlen = len(df)
    if rows:
        rowlen=rows
        df = df[:rowlen]
    for idx,row in df.iterrows():
        uid = row['bk_id']
        url = row['bk_url']
        print(idx,url)
view(rowlen)

