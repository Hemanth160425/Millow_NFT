Millow - A Decentralized Real Estate NFT Marketplace
Millow is a full-stack decentralized application (dApp) that allows users to mint, list, and trade real estate properties as Non-Fungible Tokens (NFTs) on the Ethereum blockchain. It provides a secure and transparent platform for tokenizing and transferring property ownership.

Table of Contents
About The Project

Features

Tech Stack

Getting Started

Prerequisites

Installation

Running the Project

🧪 Running Tests

Deployed Contracts

License

Contact

About The Project
This project demonstrates a real-world use case for NFTs beyond digital art by tokenizing physical assets. It features a set of smart contracts for handling NFT ownership and a secure escrow system for property sales. The user interface, built with React, allows for seamless interaction with the blockchain.

Features
Connect Wallet: Users can connect their MetaMask wallet to interact with the dApp.

Mint Properties: Mint a real estate property as a unique ERC721 NFT with associated metadata.

List Properties for Sale: Owners can list their property NFTs for sale at a set price.

Secure Escrow: A robust escrow smart contract handles the sale process, ensuring that funds and the NFT are transferred simultaneously and securely.

View Properties: Browse all minted properties and view their details, price, and ownership history.

Tech Stack
This project is built with the following technologies:

Smart Contracts (Backend):

Solidity: The language used to write the smart contracts.

Hardhat: An Ethereum development environment for compiling, deploying, testing, and debugging smart contracts.

OpenZeppelin Contracts: For secure, community-vetted implementations of standards like ERC721.

Chai & Mocha: For writing and running automated tests for the smart contracts.

Interface (Frontend):

React.js: A JavaScript library for building the user interface.

Ethers.js: A complete and compact library for interacting with the Ethereum blockchain and its smart contracts.

CSS: For styling the application.

Getting Started
Follow these steps to set up and run the project locally.

Prerequisites
Make sure you have the following installed on your machine:

Node.js (>=18.0.0)

npm or yarn

MetaMask browser extension

Installation
Clone the repository:

Bash

git clone https://github.com/your-username/millow.git
Navigate to the project directory:

Bash

cd millow
Install all dependencies:

Bash

npm install
Create an environment file:
Create a .env file in the root of the project and add your blockchain node provider URL (e.g., from Alchemy or Infura) and your private key.

Code snippet

# .env
RPC_URL="YOUR_ALCHEMY_OR_INFURA_RPC_URL"
PRIVATE_KEY="YOUR_METAMASK_PRIVATE_KEY"
Running the Project
Start a local Hardhat node:
This will create a local blockchain instance for testing.

Bash

npx hardhat node
Deploy the smart contracts to the local node:
In a new terminal window, run the deployment script.

Bash

npx hardhat run scripts/deploy.js --network localhost
Start the React frontend application:
In another terminal window, start the client.

Bash

npm run start
Connect MetaMask: Open your MetaMask extension, select the "Localhost 8545" network, and import one of the accounts provided by the npx hardhat node command.

🧪 Running Tests
The project includes a comprehensive test suite for the smart contracts, written with Mocha and Chai and executed by the Hardhat test runner.

To run the tests, execute the following command:

Bash

npx hardhat test
This command will automatically compile your smart contracts and run all test files located in the test/ directory.

The test suite covers:

NFT minting, ownership, and metadata functionality.

Property listing and purchasing logic.

The complete lifecycle of the Escrow contract.

Access control rules and security edge cases (e.g., reentrancy).
