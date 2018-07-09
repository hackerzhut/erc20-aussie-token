
## AussieToken - Simple Transfer Token in ERC-20 format

  

### About

  

- ERC20 Demo Token based on zeppelin ERC20 interface

  

### Setup

  

- Install Truffle

		npm install -g truffle

  

- Install NPM packages

		npm install

- Signup Infura to run truffle migrations

		https://infura.io/signup

Once your account is ready, Please add the `providerUrl` and `mnemonic` to config.json

	

	{

	"providerUrl": "https://ropsten.infura.io/<providerUrl>",

	"mnemonic": "<mnemonic>"

	}

	

### Compile

  

	truffle compile --all

  

### Migration & Deployment

  

- Local Deployment

		 truffle migrate --development

PS: Need `ganache-cli` (previously known as `testrpc`) installed locally.

  

- Ropsten Deployment

		truffle migrate --ropsten

  

### Testing

	npm run test
