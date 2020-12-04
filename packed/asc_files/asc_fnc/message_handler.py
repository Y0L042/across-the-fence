from cmdList import cmdList
from printHandler import *

def message_handler_c(client=None, code: str = "None", args=()):
	"""
	:param client:      client Data
	:param code:        message send
	:param args:        opt. additional arguments, passed to selected function
	:return:            nothing
	"""

	if client is None:
		print("ERROR: MSG_HANDLER_C: CLIENT DATA NOT PASSED")
		return
	if args is None:
		args = ()

	# print(f"DEBUG: MSG_HANDLER_C: Code: {code} - args: {args}")

	try:
		if len(args) > 0:
			# print("cmdList WITH Args")
			cmdList["client"][code](client=client, args=args)
		else:
			# print("cmdList WITHOUT Args")
			cmdList["client"][code](client=client)

	except KeyError as e:
		print(f"ERROR: MSG_HANDLER_C: KeyError:\ncode: {code}\nargs: {args}\nERROR MESSAGE: {e}")
		pass
	except UnicodeDecodeError as e:
		print(f"ERROR: MSG_HANDLER_C: UnicodeDecodeError:\ncode: {code}\nargs: {args}\nERROR MESSAGE: {e}")
		pass
	except AttributeError as e:
		print(f"ERROR: MSG_HANDLER_C: AttributeError:\ncode: {code}\nargs: {args}\nERROR MESSAGE: {e}")
		pass
	except Exception as e:
		print(f"ERROR: MSG_HANDLER_C: Exception:\ncode: {code}\nargs: {args}\nERROR MESSAGE: {e}")
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
		print("ERROR: MSG_HANDLER_S: sData NOT PASSED!")
		return
	if args is None:
		args = ()

	# print(f"DEBUG: MSG_HANDLER_S: Code: {code} - args: {args}")

	try:
		if len(args) > 0:
			# print("cmdList WITH Args")
			cmdList["server"][code](sData, *args)
		else:
			# print("cmdList WITHOUT Args")
			cmdList["server"][code](sData)

	except KeyError as e:
		print(f"ERROR: MSG_HANDLER_S: KeyError:\ncode: {code}\nargs: {args}\nERROR MESSAGE: {e}")
		pass
	except UnicodeDecodeError as e:
		print(f"ERROR: MSG_HANDLER_S: UnicodeDecodeError:\ncode: {code}\nargs: {args}\nERROR MESSAGE: {e}")
		pass
	except AttributeError as e:
		print(f"ERROR: MSG_HANDLER_S: AttributeError:\ncode: {code}\nargs: {args}\nERROR MESSAGE: {e}")
		pass
	except Exception as e:
		print(f"ERROR: MSG_HANDLER_S: Exception:\ncode: {code}\nargs: {args}\nERROR MESSAGE: {e}")
		pass
