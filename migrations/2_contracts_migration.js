var Migrations = artifacts.require("./AussieToken.sol");

module.exports = function (deployer) {
    deployer.deploy(Migrations);
};