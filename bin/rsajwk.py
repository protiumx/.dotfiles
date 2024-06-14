#!/opt/homebrew/bin/python3

import json
from joserfc.jwk import JWKRegistry

key = JWKRegistry.generate_key("RSA", 2048, private=False)
print(json.dumps(key.as_dict(), indent=4))
