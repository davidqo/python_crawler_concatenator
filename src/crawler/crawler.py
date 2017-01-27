import re
import codecs
import sys
import os
import requests
from urlparse import urlparse
import json

if os.path.isfile("./requests.json"):
	config = "./requests.json"
else:
	if os.path.isfile("~/requests.json"):
		config = "~/requests.txt"
	else:
		if os.path.isfile("/etc/requests.json"):
			config = "/etc/requests.json"
		else:
			raise Exception("no requests.json provided")

with open(config) as f:
    request_list = json.load(f)

#TODO: Дать возможность конфигурировать User-Agent
headers = {'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:49.0) Gecko/20100101 Firefox/49.0'}

f = codecs.open('index_new.html', mode='w', encoding='utf-8')

for req in request_list:
	result = requests.get(req["url"], headers = headers)
	parsed_uri = urlparse(req["url"])
	domain = '{uri.scheme}://{uri.netloc}/'.format(uri=parsed_uri)
	if "title" in req:
		title = req["title"]
	else:
		title = ""
	page1 = title + re.sub("src=\"", "src=\"" + domain, result.text)
	page2 = re.sub("href=\"", "href=\"" + domain, page1)
	f.write(page2)

f.close()
