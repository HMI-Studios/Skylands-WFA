from urllib.error import HTTPError
import urllib.request
import subprocess
import os
import json

print('Checking for updates...')
# try:
#   f = urllib.request.urlopen('https://api.github.com/repos/HMI-Studios/Skylands-WFA/releases/latest')
#   latest = json.load(f)
#   # Do stuff here later
#   f.close()
# except HTTPError as err:
#   if err.code != 404:
#     print(err)
#     print(err.headers)
#     exit()
#   print('No release found. Looking for pre-releases...')
#   f = urllib.request.urlopen('https://api.github.com/repos/HMI-Studios/Skylands-WFA/releases')
#   releases = json.load(f)
#   f.close()
#   # For now, just grab the first release in the list
#   f = urllib.request.urlopen(releases[0]['assets'][0]['browser_download_url'])
version = 'v0.0.1-alpha'
try:
  f = open('version.txt', 'r')
  installed_version = f.read()
  is_new_version = version != installed_version
  f.close()
except FileNotFoundError:
  is_new_version = True
f = open('version.txt', 'w')
f.write(version)
f.close()
if is_new_version:
  f = urllib.request.urlopen('https://github.com/HMI-Studios/Skylands-WFA/releases/download/%s/Skylands.exe' % (version))
  meta = f.info()
  headers = { key: value for key, value in meta._headers }
  ok = input(f"New version {version} found. {round(int(headers['Content-Length']) / 1_000_000, 2)}MB will be downloaded. Ok to download? (y/n) ")
  if ok.lower() != 'y':
    exit('Aborting.')
  print('Downloading...')
  output = open('Skylands.exe', 'wb')
  output.write(f.read())
  f.close()
  output.close()
  print('Download complete.')
else:
  print('Already up to date!')

menu_text = """
SKYLANDS WFA LAUNCHER

1. Launch Skylands
2. Uninstall Skylands
3. Exit Launcher
"""

print(menu_text)
while True:
  try:
    opt = int(input())
    if opt == 1:
      print('Launching Skylands...')
      subprocess.Popen('Skylands.exe')
      exit()
    elif opt == 2:
      ok = input('Are you sure you want to uninstall Skylands? (y/n) ')
      if ok.lower() != 'y':
        continue
      print('Uninstalling Skylands...')
      os.remove('Skylands.exe')
      os.remove('version.txt')
      print('Skylands Uninstalled.')
    elif opt == 3:
      break
    else:
      print('Unknown menu option.')
  except KeyboardInterrupt:
    break
  except ValueError:
    print('Please input a number in the list above:')

print('Goodbye.')
