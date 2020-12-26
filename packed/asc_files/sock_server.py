import random
from _thread import *
from threading import Thread
import asc_server
from printHandler import *
from asc_client import *
import time
import sys
import os
from anarchy_main.inventory import inv_handler
from anarchy_main.inventory.itemParentData import itemParentData
from anarchy_main.inventory.subtypes import subtypeData
from anarchy_main.inventory.loot_tables import loot_tables


def server_start():
    PRINT_OK("PRE: Starting Main Thread... done")
    PRINT_NEUTRAL("\n########################################################")
    PRINT_STATUS("\nMAIN: Loading config...")
    # load the config.cfg values
    try:
        rel_dir = os.path.dirname(__file__)
        filepath = os.path.join(rel_dir, "config.cfg")
        lines = open(filepath, 'r').read().split("\n")
        params = dict()
    except FileExistsError:
        PRINT_WARNING("MAIN: ERROR: config.cfg not found")
        return
    try:
        for line in lines:
            line.strip()
            if len(line) == 0 or line[0] == "#":
                continue
            key, value = list(map(lambda x: x.strip(), line.split('=')))
            if len(value) == 0:
                value = None
            params[key] = value
    except Exception as e:
        PRINT_WARNING(f"MAIN: ERROR: YOU MADE A MESS IN THE CONFIG! SHAME ON YOU! ERROR: {sys.exc_info()[0]}")
        PRINT_WARNING(e)
        return

    PRINT_OK("MAIN: Loading config... done")

    # start the socket Server
    sock_server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    PRINT_NEUTRAL("\n########################################################")
    PRINT_DEBUG(f"Path to Backend:\n##### - {params['path']}")
    databasePath = params["databasePath"]
    databaseName = params["databaseName"]
    PRINT_DEBUG(f'Path to Database:\n##### - {params["databasePath"]}{params["databaseName"]}')
    PRINT_DEBUG(f"IP:Port:\n##### - {params['ip']}:{params['port']}")
    ip = (params["ip"], int(params["port"]))
    server_key = params["server_key"]
    server_ip = params["server_ip"]
    PRINT_DEBUG(f'Server key:\n##### -> {server_key}')

    # ############# Loot/Item data thingy stuff burp
    # ####### set the main lootseed ...
    try:
        sData.lootData["globalseed"] = int(''.join(list(filter(str.isdigit, params["lootseed"])))) % 999999
    except (ValueError, KeyError, TypeError):
        PRINT_WARNING(f'!!!! WARNING:\n!!!! NO INTEGERS FOUND IN CONFIG.CFG - GENERATING RANDOM SEED\n!!!!')
        sData.lootData["globalseed"] = random.randint(0, 999999)

    PRINT_DEBUG(f'Lootseed:\n##### -> {sData.lootData["globalseed"]}')

    # ####### load all the Items to: sData.itemParentData
    itemParentData.load_files(sData=sData)
    # ####### load all the Items subTypes to: sData.itemSubTypes
    subtypeData.load_files(sData=sData)
    # ####### Create all existing subType BaseData once, so we don't have to search or build them later again
    # ####### Stored in: sData.itemClasses
    for subType in sData.itemSubTypes:
        # Do it
        data = inv_handler.item_baseData_create(sData=sData, subTypeName=subType)
        # PRINT_DEBUG(f"DEBUG: sock_server init: item baseData: subType data: {data}")
        sData.itemClasses[subType] = data

    # ####### load the loot tables
    loot_tables.load_files(sData=sData)

    PRINT_NEUTRAL("########################################################\n")

    try:
        sock_server.bind(ip)
    except socket.error as e:
        PRINT_WARNING(f'\n\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n!!!! SOCKET ALREADY IN USE! \n!!!! CHECK FOR ANOTHER RUNNING INSTANCE/PROGRAM THAT USES THE PORT: {params["port"]}\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\nError Message:')
        PRINT_WARNING(str(e))
        return

    # listen == max. backlog
    sock_server.listen(100)

    PRINT_ATTENTION('MAIN: STATUS: Waiting for game-server...')
    # wait for the Arma-Server to connect
    key_length = len(server_key)
    while True:
        # time.sleep(0.01)
        PRINT_DEBUG("MAIN: waiting for connection... ")
        con_server, raddr = sock_server.accept()
        PRINT_OK("MAIN: waiting for connection... done")

        # DEV: When testing on remote Server, get your IP and add it to the config entry: "server_ip"
        PRINT_ATTENTION(f"{time.process_time_ns()} - Connection established from: {raddr[0]}")
        if raddr[0] == server_ip:
            con_server.settimeout(1)
            try:
                PRINT_DEBUG("MAIN: waiting for message... ")
                msg = con_server.recv(key_length).decode('ascii')
                PRINT_OK("MAIN: waiting for message... done")
                PRINT_ATTENTION(f"MAIN: Checking this Server key: {msg}")
                PRINT_OK(f"MAIN: Key matched: {msg == server_key}")

                if msg == server_key:
                    con_server.settimeout(None)
                    PRINT_OK(f"MAIN: Connected from {raddr[0]}:{raddr[1]}")
                    # set ConnectionData in the sData class
                    sData.con_gameServer = con_server
                    # add the mainSocket Con, so we can close it if needed
                    sData.mainConnection = sock_server

                    # start listening thread for messages from the Server
                    Thread(target=sData.gameserver_listen, args=[databasePath, databaseName]).start()
                    break
                else:
                    PRINT_WARNING(f"MAIN: Key did not match: {msg} / {server_key} | {msg == server_key}")
                    con_server.shutdown(socket.SHUT_RDWR)
                    con_server.close()
            except socket.timeout as e:
                PRINT_WARNING(f"MAIN: failed to respond in given time: {e}")
                con_server.shutdown(socket.SHUT_RDWR)
                con_server.close()
        else:
            con_server.shutdown(socket.SHUT_RDWR)
            con_server.close()

    PRINT_OK('MAIN: STATUS: Waiting for game-server... done')

    ########################################################

    PRINT_STATUS('MAIN: STATUS: Waiting for a Clients...')
    # allow user connections
    while True:
        try:
            # time.sleep(0.1)
            con_client, raddr = sock_server.accept()
            # PRINT_DEBUG(f"raddr: {raddr} -  user_awaiting NOT empty: {len(sData.user_awaiting) > 0}")
            con_client.settimeout(2)
            if len(sData.user_awaiting) > 0:
                if sData.cur <= sData.threads_max:
                    PRINT_ATTENTION(f"MAIN: Client: New Connection from: {raddr[0]} : {raddr[1]}")
                    # create class
                    # start ClientThread to check for tKey
                    start_new_thread(client_checkKey, (sData, con_server, con_client, raddr))
                else:
                    # connection blocked
                    con_client.shutdown(socket.SHUT_RDWR)
                    con_client.close()
            else:
                PRINT_WARNING(f"MAIN: Client: Connection refused for {raddr} - closing connection")
                # connection blocked
                con_client.shutdown(socket.SHUT_RDWR)
                con_client.close()
        except OSError:
            PRINT_WARNING("MAIN: Client: SERVER CONNECTION CLOSED. Exiting...")
            # using this to "auto-close" the socket connection (cheap, but works ¯\_(ツ)_/¯ )
            break
    # graceful way of leaving:
    PRINT_WARNING("MAIN: Client: SERVER CONNECTION CLOSED. Exiting... done")


if __name__ == "__main__":
    PRINT_NEUTRAL("########################################################")
    PRINT_STATUS(f"PRE: loading data_server... ")
    sData = asc_server.data_server()
    PRINT_OK(f"PRE: loading data_server... done")
    PRINT_STATUS("PRE: Starting Main Thread...")
    server_start()

    # shutting down with a short delay, so if there are errors, they can spot them
    PRINT_WARNING("\n\n########################################################")
    PRINT_WARNING(f"MAIN: SHUTTING DOWN IN 10s")
    time.sleep(5)
    PRINT_WARNING(f"MAIN: SHUTTING DOWN IN 5s")
    time.sleep(3)
    PRINT_ATTENTION(f"cya, bye bye and have a nice day")
    time.sleep(2)
