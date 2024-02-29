import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.provider.getBalance(deployer)).toString());

  // const FeeDeductionContract = await ethers.getContractFactory("FeeDeductionContract");

  // const lok = await FeeDeductionContract.deploy(deployer.address, {

  //   gasLimit: 1000000
  // });


  // console.log("lok address ", await lok.getAddress());


  const ERC20Demo = await ethers.getContractFactory("PalletERC20Factory");

  const lok = await ERC20Demo.deploy(1000000000000, "my", "MY", {
    gasLimit: 1000000
  });

  console.log("lok address ", await lok.getAddress());

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
