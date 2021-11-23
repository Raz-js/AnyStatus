#Import additional packages
import pyyaml
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

r = requests.get('https://evo-updater.glitch.me/anystatus.htm')
if 'True' in r.text:
  print("Newer version found! Please update on Github")
  webbrowser.open("https://github.com/evo0616lution/AnyStatus")
  
  

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
with open('token.yaml') as info:
    TOKEN = next(yaml.load_all(info, Loader=yaml.FullLoader)) #Loads the token from token.yaml
with open('text.yaml') as info:
    TEXT = next(yaml.load_all(info, Loader=yaml.FullLoader)) #Loads the text from text.yaml
    
    
