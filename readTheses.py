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

arcI=Counter()
arcII=Counter()



csvfile=open('politesi.json', 'rb')

file=json.load(csvfile)
print file[0].keys();
for row in file:
    kwds = row['keywords-eng'].split(";")
    #print row['advisor']
    for k in kwds:
       
        #GENERAL
        c.update([k.strip()])
        
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
            elif "ARC I " in row['facolta']:
                arcI.update([k.strip()])
            elif "ARC II " in row['facolta']:
                arcII.update([k.strip()])
        except:
            continue
    
print len(c)

gen_file = open('general.json', 'wb')
ing_file = open('ing.json', 'wb')
arc_file = open('arc.json', 'wb')
des_file = open('des.json', 'wb')
ingI_file = open('ingI.json', 'wb')
ingII_file = open('ingII.json', 'wb')
ingIII_file = open('ingIII.json', 'wb')
ingIV_file = open('ingIV.json', 'wb')
ingV_file = open('ingV.json', 'wb')
arcI_file = open('arcI.json', 'wb')
arcII_file = open('arcII.json', 'wb')       
       
json.dump(c.most_common(),gen_file)
json.dump(ing.most_common(),ing_file)
json.dump(arc.most_common(),arc_file)
json.dump(des.most_common(),des_file)
json.dump(ingI.most_common(),ingI_file)
json.dump(ingII.most_common(),ingII_file)
json.dump(ingIII.most_common(),ingIII_file)
json.dump(ingIV.most_common(),ingIV_file)
json.dump(ingV.most_common(),ingV_file)
json.dump(arcI.most_common(),arcI_file)
json.dump(arcII.most_common(),arcII_file)

l=[]

for key in c.most_common(301):
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
        
print l
        
        



