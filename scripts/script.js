const hre = require("hardhat");

async function main() {
  const VotingDApp = await hre.ethers.getContractFactory("VotingDApp");

  // Example candidate names — you can change this array
  const candidateNames = ["Alice", "Bob", "Charlie"];
  const votingDApp = await VotingDApp.deploy(candidateNames);

  await votingDApp.deployed();

  console.log("VotingDApp deployed to:", votingDApp.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
