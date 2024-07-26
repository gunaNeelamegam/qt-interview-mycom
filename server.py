import asyncio
from websockets.server import serve
from time import sleep
import csv

DATA = []
count = 0
with open("data.csv") as fd:
  data = csv.DictReader(fd)
  for i in data.reader:
      if count == 0:
        count +=1
        continue
      DATA.append(i)

print(DATA)
from json import dumps
async def echo(websocket):
    print("CONNECTION ", websocket)
    while True:
          for line in DATA:
            line = {
                "line" : line[0],
                "date": line[1],
                "value": line[2]
            }      
            data = dumps(line)    
            await websocket.send(data)
            await asyncio.sleep(3)

async def main():
    async with serve(echo, "0.0.0.0", 8765):
        await asyncio.Future()  # run forever

asyncio.run(main())


