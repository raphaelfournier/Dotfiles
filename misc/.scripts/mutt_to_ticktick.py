#!/usr/bin/env python3
import sys
from ticktick.api import TickTickClient
from ticktick.oauth2 import OAuth2

# Configuration
CLIENT_ID="hXEeKi8t93l7z3qWUM"
CLIENT_SECRET="3B2YZwO^G5Fg6^0N^^%*Cnut!uB6KAnt"
REDIRECT_URI = 'http://127.0.0.1'
USERNAME = 'raphael@fournier-sniehotta.fr'
PASSWORD = 'Passer_8'

def create_task(title, description):
    auth_client = OAuth2(client_id=CLIENT_ID, 
                         client_secret=CLIENT_SECRET, 
                         redirect_uri=REDIRECT_URI)
    
    client = TickTickClient(USERNAME, PASSWORD, auth_client)
    
    # TickTick uses 'title' for the name and 'content' for the body/description
    task = client.task.builder(title, content=description)
    client.task.create(task)

if __name__ == "__main__":
    if len(sys.argv) > 2:
        create_task(sys.argv[1], sys.argv[2])
