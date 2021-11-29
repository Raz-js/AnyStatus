#Import additional packages
import requests
from time import sleep
import webbrowser
import discord
from discord.ext import commands
from colorama import Fore, init
init() #Initalises colorama
client = commands.Bot(
  command_prefix=':',
  self_bot=True
) #Defines the client
client.remove_command('help')

r = requests.get('https://evo-updater.glitch.me/anystatus.htm') # Checks for updates
if "1.5" not in r.text:
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

  
  
  
logo()
f = open("token.yaml", "r")
TOKEN = f.read() #Loads the token from token.yaml
f = open("text.yaml", "r")
TEXT = f.read() #Loads the text from text.yaml    
    

    
print(Fore.GREEN + "Custom status is ready!")    
print(Fore.BLUE + "Available commands:")
print(Fore.RESET + ":playing\n:watching\n:streaming\n:listening")


@client.event
async def on_message(msg):
  if msg.author == client.user:
    if msg.content == ":playing":
      await client.change_presence(activity=discord.Game(name=f"{TEXT}"))
      print("Switching to playing activity")
    elif msg.content == ":watching":
      await client.change_presence(activity=discord.Activity(type=discord.ActivityType.watching, name=f"{TEXT}"))
      print("Switching to watching activity")
    elif msg.content == ":streaming":
      await client.change_presence(activity=discord.Streaming(name=f"{TEXT}", url="https://twitch.tv/discord"))
      print("Switching to streaming activity")
    elif msg.content == ":listening":
      await client.change_presence(activity=discord.Activity(type=discord.ActivityType.listening, name=f"{TEXT}"))
      print("Switching to listening activity")
    else:
      return
  else:
    return

      
client.run(TOKEN, bot=False)
