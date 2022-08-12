/** @type import('hardhat/config').HardhatUserConfig */

require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");

module.exports = {
  solidity: "0.8.7",
  networks:{
    polygon:{
      url: "https://rpc-mumbai.maticvigil.com/",
      accounts: ["2c560573c3d404d0a0bc60e0929fee6a73fa561c3c5abd0d43b548656cbcad6e"]
    }
  },
  etherscan:{
    apiKey: "QV1HUEMW8KHCCAWD8FWC5JTAWSB86PEICF"
  }
};
