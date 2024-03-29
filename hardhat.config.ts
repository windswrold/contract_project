import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-verify";


import {
  EtherscanConfig,
  getHardhatNetworkConfig,
  HardhatGasReporterConfig,
  HardhatSolidityConfig,
} from "./SmartContractProjectConfig/config";

const networks = getHardhatNetworkConfig();

const etherscan = EtherscanConfig;


const config: HardhatUserConfig = {
  networks,
  mocha: {
    timeout: 500000,
  },
  solidity: "0.8.20",
  etherscan: etherscan, 
  sourcify: {
    enabled: true
  }
};

export default config;
