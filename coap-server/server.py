#!/usr/bin/env python3

import datetime
import logging

import asyncio

import aiocoap.resource as resource
import aiocoap

class ResourceTemperature(resource.Resource):
    def __init__(self):
        super().__init__()
        self._t=""

    async def render_get(self, request):
        return aiocoap.Message(content_format=0,
                               payload=self._t.encode('utf8'))

    async def render_put(self, request):
        self._t= request.payload.decode("utf8")
        print("Received Temperature:", self._t)

        response_payload = "Received Temperature: " + self._t + " C"
        return aiocoap.Message(content_format=0,
                               payload=response_payload.encode('utf8'))

class ResourceHumidity(resource.Resource):
    def __init__(self):
        super().__init__()
        self._h= ""

    async def render_get(self, request):
        return aiocoap.Message(content_format=0,
                               payload=self._h.encode('utf8'))

    async def render_put(self, request):
        self._h= request.payload.decode("utf8")
        print("Received Humidity:", self._h)

        response_payload = "Received Humidity: " + self._h  + " %"
        return aiocoap.Message(content_format=0,
                               payload=response_payload.encode('utf8'))

class ResourceHeatIndex(resource.Resource):
    def __init__(self):
        super().__init__()
        self._hi=""

    async def render_get(self, request):
        return aiocoap.Message(content_format=0,
                               payload=self._hi.encode('utf8'))

    async def render_put(self, request):
        self._hi=request.payload.decode('utf8')
        print("Received Heat Index:", self._hi)

        response_payload = "Received Heat Index: " + self._hi  + " C"
        return aiocoap.Message(content_format=0,
                               payload=response_payload.encode('utf8'))

# logging setup
logging.basicConfig(level=logging.INFO)
logging.getLogger("coap-server").setLevel(logging.DEBUG)

async def main():

    # Resource tree creation
    root = resource.Site()
    root.add_resource(['temperature'], ResourceTemperature())
    root.add_resource(['humidity'], ResourceHumidity())
    root.add_resource(['heatindex'], ResourceHeatIndex())

    await aiocoap.Context.create_server_context(root)

    # Run forever
    await asyncio.get_running_loop().create_future()

if __name__ == "__main__":
    asyncio.run(main())
