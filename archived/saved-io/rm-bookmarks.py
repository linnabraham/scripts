import requests
from urllib.parse import urlencode
import csv
import pandas as pd
import sys
import saved as config

baseurl = 'http://devapi.saved.io/bookmarks?'
apikey = config.apikey
userkey = config.userkey

token = {'devkey': apikey,'key':userkey}

filepath=config.FILEPATH

def remove(linelist):
    # data = pd.read_csv(filepath)
    data = pd.read_csv(filepath,sep=',',lineterminator='\n')
    for i in linelist:
        uid = data['bk_id'].iloc[int(i)]
        # print(f"uid is {uid}")
        token['id'] = uid
        print(token)
        requests.delete(baseurl,params=token)
        indexNames = data[ data['bk_id'] == uid ].index
        data.drop(indexNames,inplace=True)
    data.to_csv(filepath,index=False,line_terminator='\n')
args = sys.argv
delete_list = args[1:]

remove(delete_list)
    
        
