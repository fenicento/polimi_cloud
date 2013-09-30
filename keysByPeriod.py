

import json
from collections import Counter,defaultdict


csvfile=open('politesi.json', 'rb')

file=json.load(csvfile)

c=Counter();
kw=Counter();
obj=dict()



def addOrCreate(v1,v2,v3):
    print "in"
    try:
        obj[v1][v2][v3]+=1
    except:
        print "1"
        try:
            obj[v1][v2][v3]=1
        except:
            print "2"
            try:
                obj[v1][v2]=dict()
                obj[v1][v2][v3]=1
            except:
                print "3"
                obj[v1]=dict()
                obj[v1][v2]=dict()
                obj[v1][v2][v3]=1
            


for i in file:
    if i['accessioned'] is not None:
        s= i['accessioned'][:7].split("-")
        if int(s[1])>=7: 
            s[1]="2"
        else:
            s[1]="1"  
        
        
        c.update([s[0]+"-"+s[1]])

print c



for row in file:
    kwds = row['keywords-eng'].split(";")
    #print row['advisor']
    for k in kwds:
       
        if k.strip()!=" " and k.strip()!="":
            kw.update([k.strip()])
        
y=[x[0] for x in kw.most_common(400)]
print y


for row in file:
    kwds = row['keywords-eng'].split(";")
    #print row['advisor']
    for k in kwds:
        if k.strip() in y and row['facolta'] is not None and row['facolta']!="" and row['accessioned'] is not None:
            #print k.strip()
            
            s= row['accessioned'][:7].split("-")
            if int(s[1])>=7: 
                s[1]="2"
            else:
                s[1]="1"  
            
            
            if "ING I " in row['facolta']:
                addOrCreate(k.strip(),s[0]+"-"+s[1],"ingI")
            elif "ING II " in row['facolta']:
                addOrCreate(k.strip(),s[0]+"-"+s[1],"ingII")
            elif "ING III " in row['facolta']:
                addOrCreate(k.strip(),s[0]+"-"+s[1],"ingIII")
            elif "ING IV " in row['facolta']:
                addOrCreate(k.strip(),s[0]+"-"+s[1],"ingIV")
            elif "ING V " in row['facolta']:
                addOrCreate(k.strip(),s[0]+"-"+s[1],"ingV")
            elif "ING VI " in row['facolta']:
                addOrCreate(k.strip(),s[0]+"-"+s[1],"ingVI")
            elif "ARC I " in row['facolta']:
                addOrCreate(k.strip(),s[0]+"-"+s[1],"arcI")
            elif "ARC II " in row['facolta']:
                addOrCreate(k.strip(),s[0]+"-"+s[1],"arcII")
            elif "ARC III " in row['facolta']:
                addOrCreate(k.strip(),s[0]+"-"+s[1],"des")



for i in obj.keys():
    for b in c:
        if b not in obj[i].keys():
            obj[i][b]=dict()
            obj[i][b]["ingI"]=0
            obj[i][b]["ingII"]=0
            obj[i][b]["ingIII"]=0
            obj[i][b]["ingIV"]=0
            obj[i][b]["ingV"]=0
            obj[i][b]["ingVI"]=0
            obj[i][b]["arcI"]=0
            obj[i][b]["arcII"]=0
            obj[i][b]["des"]=0
        
        else:
            if "ingI" not in obj[i][b].keys():
               obj[i][b]["ingI"]=0 
            
            if "ingII" not in obj[i][b].keys():
               obj[i][b]["ingII"]=0 
               
            if "ingIII" not in obj[i][b].keys():
               obj[i][b]["ingIII"]=0 
               
            if "ingIV" not in obj[i][b].keys():
               obj[i][b]["ingIV"]=0 
               
            if "ingV" not in obj[i][b].keys():
               obj[i][b]["ingV"]=0 
               
            if "ingVI" not in obj[i][b].keys():
               obj[i][b]["ingVI"]=0 
               
            if "arcI" not in obj[i][b].keys():
               obj[i][b]["arcI"]=0 
               
            if "arcII" not in obj[i][b].keys():
               obj[i][b]["arcII"]=0 
               
            if "des" not in obj[i][b].keys():
               obj[i][b]["des"]=0 
            
         

print obj

with open('total_new.json','w') as outfile:
    json.dump(obj,outfile)


            

            
            
