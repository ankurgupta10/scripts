from skpy import Skype
from datetime import datetime
import random
import time

content = ""
delay   = 9999
startmsg= ['start','starting','startng','started']
closemsg=['close','closing','closure','closin']
# SET CONTENT AND DELAY AS PER TIME
now = datetime.now()
current_hour = now.strftime("%H")
current_day  = now.strftime("%A")
print("Current hour =", current_hour,current_day)

if(current_hour == "12"): 
    content = random.choice(startmsg)
    delay = random.randint(0,300)
if(current_hour == "17"): 
    content = random.choice(closemsg)
    delay = random.randint(0,900)

if(current_day == 'Saturday' or current_day == 'Sunday'):delay=0
print("delay:",delay,"sec= ",int(delay/60),"MIN",delay%60,"S")
print("starting at:",now.strftime("%H:%M:%S"))
time.sleep(delay)

#SET random DOTS after CONTENT - execute after delay
dots = "..."
n = random.randint(0,3)
content1 = content + dots[0:n]
content2 = "sent='"+content1+"'   after delay=" + str(delay) + "s    to Neha Sharma HR SOFTELEVATION"


# LOGIN AND SEND
def connect_skype(user, pwd, token):
    s = Skype(connect=False)
    s.conn.setTokenFile(token)
    try:
        s.conn.readToken()
    except SkypeAuthException:
        s.conn.setUserPwd(user, pwd)
        s.conn.getSkypeToken()
        s.conn.writeToken()
    finally:
        sk = Skype(user, pwd, tokenFile=token)
    return sk

# LOGIN
print("LOGGING AND SENDING...")
sk = connect_skype("ankur@softelevation.com", "soft1234", "C:\\Users\\hp\\Desktop\\tokenmohali.txt")    # connect to Skype

# SEND
if(current_day == 'Saturday' or current_day == 'Sunday'):
    # sk.setPresence("Away")
    sk.setMood("brb")
    print("SAT SUN off")
else:
    # sk.setPresence("Online")
    sk.setMood("Online")
    time.sleep(2)           
    ch1 = sk.contacts["live:.cid.377ed11230281a48"].chat # NEHA SHARMA HR
    ch1.sendMsg(content1)                                # SEND plain-text message
    # ch2 = sk.contacts["live:acd.gkg_2"].chat             # send to acd.gkg@outlook.com
    # ch2.sendMsg("content2")                                # SEND plain-text message

# OTHER FNS
print("COMPLETE")
input()
