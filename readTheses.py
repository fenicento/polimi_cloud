'''
Created on Sep 13, 2013

@author: davide
'''

import json
from collections import Counter

c=Counter()
ing=Counter()
arc=Counter()
des=Counter()

ingI=Counter()
ingII=Counter()
ingIII=Counter()
ingIV=Counter()
ingV=Counter()
ingVI=Counter()

arcI=Counter()
arcII=Counter()

keywords=list()

csvfile=open('politesi.json', 'rb')

file=json.load(csvfile)
print file[0].keys();
for row in file:
    kwds = row['keywords-eng'].split(";")
    #print row['advisor']
    for k in kwds:
       
        #GENERAL
        c.update([k.strip()])
        keywords.append(k.strip())
        
        #FACULTIES
        try:  
            if "Ingegneria" in row['facolta']:
                ing.update([k.strip()])
            
            elif "Architettura" in row['facolta']:
                arc.update([k.strip()])
                
            elif "Design" in row['facolta']:
                des.update([k.strip()])
        except:
            continue

        #SCHOOLS
        
        try:  
            if "ING I " in row['facolta']:
                ingI.update([k.strip()])
            elif "ING II " in row['facolta']:
                ingII.update([k.strip()])
            elif "ING III " in row['facolta']:
                ingIII.update([k.strip()])
            elif "ING IV " in row['facolta']:
                ingIV.update([k.strip()])
            elif "ING V " in row['facolta']:
                ingV.update([k.strip()])
            elif "ING VI " in row['facolta']:
                ingVI.update([k.strip()])
            elif "ARC I " in row['facolta']:
                arcI.update([k.strip()])
            elif "ARC II " in row['facolta']:
                arcII.update([k.strip()])
        except:
            continue
    
print len(c)

key_file = open('keys.json', 'wb')
gen_file = open('general.json', 'wb')
ing_file = open('ITing.json', 'wb')
arc_file = open('ITarc.json', 'wb')
des_file = open('ITdes.json', 'wb')
ingI_file = open('ITingI.json', 'wb')
ingII_file = open('ITingII.json', 'wb')
ingIII_file = open('ITingIII.json', 'wb')
ingIV_file = open('ITingIV.json', 'wb')
ingV_file = open('ITingV.json', 'wb')
arcI_file = open('ITarcI.json', 'wb')
arcII_file = open('ITarcII.json', 'wb')

total_file = open('total500.json', 'wb')    
       
json.dump(c.most_common(500),gen_file)
json.dump(ing.most_common(),ing_file)
json.dump(arc.most_common(),arc_file)
json.dump(des.most_common(),des_file)
json.dump(ingI.most_common(),ingI_file)
json.dump(ingII.most_common(),ingII_file)
json.dump(ingIII.most_common(),ingIII_file)
json.dump(ingIV.most_common(),ingIV_file)
json.dump(ingV.most_common(),ingV_file)
json.dump(ingVI.most_common(),ingV_file)
json.dump(arcI.most_common(),arcI_file)
json.dump(arcII.most_common(),arcII_file)

json.dump(keywords[:500],key_file)

l=[]

for key in c.most_common(501):
    if len(key[0])>1:
        o={"name":key[0],"tot":key[1]}
        
        if ingI[key[0]] is not None:
            o['ingI']=ingI[key[0]]
        else:
            o['ingI']=0
            
        if ingII[key[0]] is not None:
            o['ingII']=ingII[key[0]]
        else:
            o['ingII']=0
            
        if ingIII[key[0]] is not None:
            o['ingIII']=ingIII[key[0]]
        else:
            o['ingIII']=0
            
        if ingIV[key[0]] is not None:
            o['ingIV']=ingIV[key[0]]
        else:
            o['ingIV']=0
            
        if ingV[key[0]] is not None:
            o['ingV']=ingV[key[0]]
        else:
            o['ingV']=0

        if ingV[key[0]] is not None:
            o['ingVI']=ingVI[key[0]]
        else:
            o['ingVI']=0
            
        if arcI[key[0]] is not None:
            o['arcI']=arcI[key[0]]
        else:
            o['arcI']=0
            
        if arcII[key[0]] is not None:
            o['arcII']=arcII[key[0]]
        else:
            o['arcII']=0
        
        if des[key[0]] is not None:
            o['des']=des[key[0]]
        else:
            o['des']=0
            
            
            
        l.append(o)
        
json.dump(l,total_file);
        
        



