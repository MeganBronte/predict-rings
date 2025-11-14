#!/usr/bin/env node

const { ethers } = require("hardhat");

async function main() {
  console.log("Deploying FHEVM contracts...");

  // Deploy FHECounter
  console.log("Deploying FHECounter...");
  const FHECounter = await ethers.getContractFactory("FHECounter");
  const fheCounter = await FHECounter.deploy();
  await fheCounter.waitForDeployment();
  const fheCounterAddress = await fheCounter.getAddress();
  console.log("FHECounter deployed to:", fheCounterAddress);

  // Deploy EncryptedLuckyDraw with max participants
  const maxParticipants = 100;
  console.log(`Deploying EncryptedLuckyDraw with max ${maxParticipants} participants...`);
  const EncryptedLuckyDraw = await ethers.getContractFactory("EncryptedLuckyDraw");
  const encryptedLuckyDraw = await EncryptedLuckyDraw.deploy(maxParticipants);
  await encryptedLuckyDraw.waitForDeployment();
  const encryptedLuckyDrawAddress = await encryptedLuckyDraw.getAddress();
  console.log("EncryptedLuckyDraw deployed to:", encryptedLuckyDrawAddress);

  // Verify deployments
  console.log("\nVerifying deployments...");
  const [deployer] = await ethers.getSigners();
  console.log("Deployed by:", deployer.address);

  // Test basic functionality
  console.log("\nTesting basic functionality...");

  // Test FHECounter
  const initialCount = await fheCounter.getCount();
  console.log("FHECounter initial encrypted count:", initialCount);

  // Test EncryptedLuckyDraw
  const admin = await encryptedLuckyDraw.admin();
  const maxParts = await encryptedLuckyDraw.maxParticipants();
  console.log("EncryptedLuckyDraw admin:", admin);
  console.log("EncryptedLuckyDraw max participants:", maxParts);

  console.log("\n✅ All contracts deployed successfully!");
  console.log("FHECounter:", fheCounterAddress);
  console.log("EncryptedLuckyDraw:", encryptedLuckyDrawAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
