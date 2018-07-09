const HDWalletProvider = require("truffle-hdwallet-provider");
const config = require('./config.json');

module.exports = {
  networks: {
    ropsten: {
      provider: function () {
        return new HDWalletProvider(config.mnemonic, config.providerUrl);
      },
      network_id: '3',
      gas: 4412388
    },
    development: {
      provider: function () {
        return new HDWalletProvider(config.mnemonic, "http://127.0.0.1:8545/");
      },
      network_id: '*'
    }
  }
};
