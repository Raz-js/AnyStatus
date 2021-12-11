#Import additional packages
import requests
from time import sleep
import webbrowser
import discord
import asyncio
import json
import sys
from discord.ext import commands
from colorama import Fore, init
from playsound import playsound
init() #Initalises colorama
client = commands.Bot(
  command_prefix=':',
  self_bot=True
) #Defines the client
client.remove_command('help')

r = requests.get('https://evo-updater.glitch.me/anystatus.htm') # Checks for updates
if "2.1" not in r.text:
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

if TOKEN == "default":
  tkn = input("Your discord token: ")
  a_file = open("config.json", "r")
  json_object = json.load(a_file)
  json_object["token"] = tkn
  a_file = open("config.json", "w")
  json.dump(json_object, a_file)
  print("Please restart AnyStatus in order to save the changes")
  sleep(2)
  sys.exit()

    

logo() 
playsound("jingle.wav")
print(Fore.GREEN + "Custom presence is ready!")    
print(Fore.BLUE + "Available commands:")
print(Fore.RESET + f"{PREFIX}playing = <text>\n{PREFIX}watching = <text>\n{PREFIX}streaming = <text>\n{PREFIX}listening = <text>\n{PREFIX}stop")


@client.event
async def on_message(msg):
  if msg.author == client.user:
    if f"{PREFIX}playing" in msg.content:
      x = msg.content.split("= ")
      val = x[1]
      await client.change_presence(activity=discord.Game(name=f"{val}"))
      print(Fore.BLUE + "[>>] Switching to playing activity")
      playsound("playing.wav")
      await msg.delete()
    elif f"{PREFIX}watching" in msg.content:
      x = msg.content.split("= ")
      val = x[1]
      await client.change_presence(activity=discord.Activity(type=discord.ActivityType.watching, name=f"{val}"))
      print(Fore.BLUE + "[>>] Switching to watching activity")
      playsound("watching.wav")
      await msg.delete()
    elif f"{PREFIX}streaming" in msg.content:
      x = msg.content.split("= ")
      val = x[1]
      await client.change_presence(activity=discord.Streaming(name=f"{val}", url="https://twitch.tv/discord"))
      print(Fore.BLUE + "[>>] Switching to streaming activity")
      playsound("streaming.wav")
      await msg.delete()
    elif f"{PREFIX}listening" in msg.content:
      x = msg.content.split("= ")
      val = x[1]
      await client.change_presence(activity=discord.Activity(type=discord.ActivityType.listening, name=f"{val}"))
      print(Fore.BLUE + "[>>] Switching to listening activity")
      playsound("listening.wav")
      await msg.delete()
    elif f"{PREFIX}stop" in msg.content:
      await client.change_presence(activity=None)
      print(Fore.BLUE + "[>>] Stopping activity")
      playsound("stopping.wav")
      await msg.delete()
    else:
      return
  else:
    return

      
client.run(TOKEN, bot=False)
