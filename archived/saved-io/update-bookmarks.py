import requests
import sys
import csv
import pandas as pd
from urllib.parse import urlencode
import saved as config


apikey = config.apikey
userkey = config.userkey
baseurl = 'http://devapi.saved.io/bookmarks?'
token = {'devkey': apikey,'key':userkey,'page':1}

filepath=config.FILEPATH

def update():
    # data = pd.read_csv(filepath)
    data = pd.read_csv(filepath,sep=',',lineterminator='\n')
    for i in range(5):
        r = requests.get(baseurl, params = token)
        # print(r)
        bookmarks = eval(r.text)
        fnd = False
        for b in bookmarks:
            uid, title, url = b['bk_id'], b['bk_title'], b['bk_url']
            title = title.replace('\/', '/')
            url = url.replace('\/', '/')
            b['bk_title']=title
            b['bk_url']=url
            # print(f"bookmark id is {b['bk_id']}")
            for idx, row in data.iterrows():
                if row['bk_id']==uid:
                    fnd = True
                    break

            if not fnd:
                data = data.append(b,ignore_index=True)
                print("updated")
                break
        token['page']+=1
    if fnd:
        print("up-to-date")
    data.to_csv(filepath,index=False,line_terminator='\n')
update()
