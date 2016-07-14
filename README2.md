This library is made possible by the work of the following people/teams:
- Eris Industries (https://erisindustries.com)
- Go team ()
- SUPERCOP team (http://ed25519.cr.yp.to/)
- Milagro team (https://github.com/miracl/milagro-crypto)
- Sjors (https://github.com/CryptoCoinSwift/RIPEMD-Swift)

The source code and accompanying files are provided under the Apache v2 license (or respective license for prior work).

This framework provides generation, signing and verification capabilities of the Eris Keys (ED25519/RipeMD160) in Swift. The relevant class is ErisKey (in ./Common/erisKey.swift).

./Common/ed25519 contains the ed25519 implementation.
./Common/ripemd contains the RIPEMD160 implementation.
./Common/randomentropy
./CommonCrypto contains the necessary files to expose CommonCrypto to Swift.


Sample usage code in the playground.


There are 2 universal targets for ios (ErisKeysUniversal and CommonCryptoUniversal)). They are both needed in order to use the ErisKeys framework.

Currently, they will generate the frameworks in ${HOME}/Desktop/.

For now, only iOS and macOS are supported. There are currently no tests.


