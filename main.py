import requests
import sys, os
from time import sleep
import webbrowser
import discord
import json
from colorama import Fore, init
from discord.ext import commands
from console.utils import set_title

init()  # Initializes colorama
set_title("AnyStatus | By github.com/pacity")

client = commands.Bot(
    command_prefix=':',
    self_bot=True,
    intents=discord.Intents.all()
)
client.remove_command('help')

# ------------------------
# CURRENT VERSION GOES HERE:
version = "2.3"
# ----------------------------

r = requests.get('https://pacity-database.glitch.me/anystatus.htm')  # Checks for updates
if version not in r.text:
    print("Newer version found! Please update on Github")
    sleep(2)
    webbrowser.open("https://pacity-database.glitch.me/anystatus-download.htm")
    sys.exit()


def logo():
    print(Fore.YELLOW + """
    ___                _____ __        __            
   /   |  ____  __  __/ ___// /_____ _/ /___  _______
  / /| | / __ \/ / / /\__ \/ __/ __ `/ __/ / / / ___/
 / ___ |/ / / / /_/ /___/ / /_/ /_/ / /_/ /_/ (__  ) 
/_/  |_/_/ /_/\__, //____/\__/\__,_/\__/\__,_/____/  
             /____/                                  
""")
    print(Fore.RESET + "Made by https://github.com/pacity")


with open("config.json") as file:
    info = json.load(file)
    TOKEN = info["token"]
    PREFIX = info["prefix"]

if TOKEN == "default":
    tkn = input("Your discord token: ")
    info["token"] = tkn
    with open("config.json", "w") as file:
        json.dump(info, file)
    print("Please restart AnyStatus in order to save the changes")
    sleep(2)
    sys.exit()


logo()
print(Fore.GREEN + "Custom presence is ready!")
print(Fore.BLUE + "Available commands:")
print(Fore.RESET + f"{PREFIX}playing = <text>\n{PREFIX}watching = <text>\n{PREFIX}streaming = <text>\n{PREFIX}listening = <text>\n{PREFIX}stop")


@client.event
async def on_message(msg):
    if msg.author == client.user:
        content = msg.content.strip()
        if content.startswith(f"{PREFIX}playing"):
            val = content.replace(f"{PREFIX}playing", "").strip()
            await client.change_presence(activity=discord.Game(name=val))
            print(Fore.BLUE + "[>>] Switching to playing activity")
            await msg.delete()
        elif content.startswith(f"{PREFIX}watching"):
            val = content.replace(f"{PREFIX}watching", "").strip()
            await client.change_presence(activity=discord.Activity(type=discord.ActivityType.watching, name=val))
            print(Fore.BLUE + "[>>] Switching to watching activity")
            await msg.delete()
        elif content.startswith(f"{PREFIX}streaming"):
            val = content.replace(f"{PREFIX}streaming", "").strip()
            await client.change_presence(activity=discord.Streaming(name=val, url="https://twitch.tv/discord"))
            print(Fore.BLUE + "[>>] Switching to streaming activity")
            await msg.delete()
        elif content.startswith(f"{PREFIX}listening"):
            val = content.replace(f"{PREFIX}listening", "").strip()
            await client.change_presence(activity=discord.Activity(type=discord.ActivityType.listening, name=val))
            print(Fore.BLUE + "[>>] Switching to listening activity")
            await msg.delete()
        elif content.startswith(f"{PREFIX}stop"):
            await client.change_presence(activity=None)
            print(Fore.BLUE + "[>>] Stopping activity")
            await msg.delete()


client.run(TOKEN, bot=False)
