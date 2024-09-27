import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.provider.getBalance(deployer)).toString());

  const CapybaraNFT = await ethers.getContractFactory("CapybaraNFT");
  const contract = await CapybaraNFT.deploy(deployer.address, "https://imagery.ccapy.com/images/nft/json/{id}.json",
    {
      gasLimit: 3000000
    }
  );
  console.log("contract address ", await contract.getAddress());






  //npx hardhat verify --network mainnet DEPLOYED_CONTRACT_ADDRESS "Constructor argument 1"

}

// async function verify(address: string, constructorArguments: []) {

//   // await run(`verify:verify`);
// }

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
