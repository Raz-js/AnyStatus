#Import additional packages
import requests
from time import sleep
import webbrowser
import discord
import asyncio
import json
from discord.ext import commands
from colorama import Fore, init
init() #Initalises colorama
client = commands.Bot(
  command_prefix=':',
  self_bot=True
) #Defines the client
client.remove_command('help')

r = requests.get('https://evo-updater.glitch.me/anystatus.htm') # Checks for updates
if "1.7" not in r.text:
  print("Newer version found! Please update on Github")
  webbrowser.open("https://github.com/evo0616lution/AnyStatus/releases")
  
  

def logo(): #Defines the logo
  print(Fore.YELLOW + """

    ___                _____ __        __            
   /   |  ____  __  __/ ___// /_____ _/ /___  _______
  / /| | / __ \/ / / /\__ \/ __/ __ `/ __/ / / / ___/
 / ___ |/ / / / /_/ /___/ / /_/ /_/ / /_/ /_/ (__  ) 
/_/  |_/_/ /_/\__, //____/\__/\__,_/\__/\__,_/____/  
             /____/                                  

""")
  print(Fore.RESET + "Made by https://github.com/evo0616lution")

  
with open("config.json") as file:
    info = json.load(file)
    TOKEN = info["token"]
    PREFIX = info["prefix"] 


    

logo()  
sleep(1)
print(Fore.GREEN + "Custom presence is ready!")    
print(Fore.BLUE + "Available commands:")
print(Fore.RESET + f"{PREFIX}playing <text>\n{PREFIX}watching <text>\n{PREFIX}streaming <text>\n{PREFIX}listening <text>")


@client.event
async def on_message(msg):
  if msg.author == client.user:
    if f"{PREFIX}playing" in msg.content:
      x = msg.content.split(" ")
      val = x[1]
      await client.change_presence(activity=discord.Game(name=f"{val}"))
      print(Fore.BLUE + "[>>] Switching to playing activity")
      await asyncio.sleep(1)
      await msg.delete()
    elif f"{PREFIX}watching" in msg.content:
      x = msg.content.split(" ")
      val = x[1]
      await client.change_presence(activity=discord.Activity(type=discord.ActivityType.watching, name=f"{val}"))
      print(Fore.BLUE + "[>>] Switching to watching activity")
      await asyncio.sleep(1)
      await msg.delete()
    elif f"{PREFIX}streaming" in msg.content:
      x = msg.content.split(" ")
      val = x[1]
      await client.change_presence(activity=discord.Streaming(name=f"{val}", url="https://twitch.tv/discord"))
      print(Fore.BLUE + "[>>] Switching to streaming activity")
      await asyncio.sleep(1)
      await msg.delete()
    elif f"{PREFIX}listening" in msg.content:
      x = msg.content.split(" ")
      val = x[1]
      await client.change_presence(activity=discord.Activity(type=discord.ActivityType.listening, name=f"{val}"))
      print(Fore.BLUE + "[>>] Switching to listening activity")
      await asyncio.sleep(1)
      await msg.delete()
    else:
      return
  else:
    return

      
client.run(TOKEN, bot=False)
