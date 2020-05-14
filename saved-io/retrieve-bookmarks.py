# this script is meant to be run only once 
import requests
from urllib.parse import urlencode
import csv
import sys
import pandas as pd
import saved as config

args = sys.argv
num = int(args[1])
filepath=config.FILEPATH

baseurl = 'http://devapi.saved.io/bookmarks?'
apikey = config.apikey
userkey = config.userkey
startpage = 1

token = {'devkey': apikey,'key':userkey,'page':startpage}

def initialize(maxpages = 200):
    data = pd.DataFrame()
    lastid = ''
    next=True
    for i in range(maxpages):
        try:
            r = requests.get(baseurl, params = token)
        except Exception as e:
            print(e)
        bookmarks = eval(r.text)
        if next:
            print(f"page no{i}, lastid {lastid}")
            for b in bookmarks:
                idx, title, url = b['bk_id'], b['bk_title'], b['bk_url']
                # print(idx)
                title = title.replace('\/', '/')
                url = url.replace('\/', '/')
                b['bk_title']=title
                b['bk_url']=url
                data = data.append(b,ignore_index=True)
                if idx ==lastid:
                    next=False
                    break
            lastid = idx
        else:
            break
        token['page']+=1
    data.to_csv(filepath,index=False,line_terminator='\n')
# initialize(num)
