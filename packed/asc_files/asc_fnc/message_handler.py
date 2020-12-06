from cmdList import cmdList
from printHandler import *

def message_handler_c(client=None, code: str = "None", args=None):
	"""
	:param client:      client Data
	:param code:        message send
	:param args:        opt. additional arguments, passed to selected function
	:return:            nothing
	"""

	if client is None:
		PRINT_WARNING("ERROR: MSG_HANDLER_C: CLIENT DATA NOT PASSED")
		return
	if args is None:
		args = ()

	# PRINT_DEBUG(f"DEBUG: MSG_HANDLER_C: Code: {code} - args: {args}")

	if code in cmdList["client"]:
		if len(args) > 0:
			# PRINT_DEBUG("cmdList WITH Args")
			cmdList["client"][code](client=client, args=args)
		else:
			# PRINT_DEBUG("cmdList WITHOUT Args")
			cmdList["client"][code](client=client)
	else:
		PRINT_WARNING(f"\nERROR: MSG_HANDLER_C: PASSED CODE NOT FOUND:\ncode: {code}\nargs: {args}\n")
		pass


def message_handler_s(sData=None, code: str = "None", args=None):
	"""
	:param code:        message send
	:param sData:
	:param args:        opt. additional arguments, passed to selected function
	:return:            nothing
	"""
	if sData is None:
		# DEV
		PRINT_WARNING("ERROR: MSG_HANDLER_S: sData NOT PASSED!")
		return
	if args is None:
		args = ()

	# PRINT_DEBUG(f"DEBUG: MSG_HANDLER_S: Code: {code} - args: {args}")

	if code in cmdList["server"]:
		if len(args) > 0:
			# PRINT_DEBUG("cmdList WITH Args")
			cmdList["server"][code](sData, *args)
		else:
			# PRINT_DEBUG("cmdList WITHOUT Args")
			cmdList["server"][code](sData)
	else:
		PRINT_WARNING(f"\nERROR: MSG_HANDLER_S: PASSED CODE NOT FOUND:\ncode: {code}\nargs: {args}\n")
		pass
