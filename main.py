import pyyaml
from time import sleep
import discord
from discord.ext import commands
from colorama import Fore, init
init()
client = commands.Bot(
  command_prefix=':',
  self_bot=True
)
client.remove_command('help')
def logo():
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
    TOKEN = next(yaml.load_all(info, Loader=yaml.FullLoader))
with open('text.yaml') as info:
    TEXT = next(yaml.load_all(info, Loader=yaml.FullLoader)) 
