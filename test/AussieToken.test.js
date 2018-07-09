const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
const { abi, bytecode } = require('./../build/contracts/AussieToken.json');
var BigNumber = web3.utils.BN;
let accounts;
let owner;
let token;

describe('Aussie Token', () => {

    before(async () => {
        accounts = await web3.eth.getAccounts();
        owner = accounts[0];
        token = await new web3.eth.Contract(abi)
            .deploy({ data: bytecode })
            .send({ from: owner, gas: '1000000' });
    });

    it('deploys a contract', async () => {
        assert.ok(token.options.address);
    });

    it('transfer money to a given address', async () => {
        const _to = accounts[1];
        const _value = web3.utils.toWei('2', 'ether');
        const senderInitialBalance = await token.methods.balanceOf(owner).call();
        const receipt = await token.methods.transfer(_to, _value).send({ from: owner });
        const senderFinalBalance   = await token.methods.balanceOf(owner).call();
        const receiverBalance = await token.methods.balanceOf(_to).call();
        const difference = senderInitialBalance - senderFinalBalance;

        assert(difference > web3.utils.toWei('1.9', 'ether'))
        assert.strictEqual(receiverBalance, _value);
    });
});