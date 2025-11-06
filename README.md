# Encrypted Lucky Draw - FHEVM Project

**Live Demo**: [https://pr06.vercel.app/](https://pr06.vercel.app/)

A privacy-preserving lottery system built with Fully Homomorphic Encryption (FHE) using Zama's FHEVM. Participants can submit encrypted identifiers and verify results without revealing personal information.

## Features

- **Privacy-First Lottery**: Fully encrypted participant registration and winner selection
- **Verifiable Results**: Participants can privately verify if they won without exposing data
- **FHE Counter Demo**: Interactive demonstration of homomorphic encryption operations
- **Secure Wallet Integration**: RainbowKit integration for secure wallet connections

## Project Structure

### Smart Contracts (Solidity)
- `FHECounter.sol`: A demonstration contract showcasing FHE operations (increment, decrement, reset)

### Frontend (Next.js + React)
- Modern React application with TypeScript
- RainbowKit for wallet connectivity
- Zama FHEVM SDK integration for client-side encryption/decryption

### Testnet Deployment
- **Network**: Sepolia Testnet
- **FHECounter Contract**: Deployed using Zama FHEVM

## Process Flow

1. **Encrypt**: Participants choose a numeric ID and encrypt it locally using FHE
2. **Submit**: Register on-chain with encrypted identifier (no personal data exposed)
3. **Draw**: Admin triggers encrypted random winner selection
4. **Verify**: Participants privately decrypt and verify results

## Demo Video

Watch the project demonstration: [Prize-draw.mp4](Prize-draw.mp4)

## Technology Stack

- **Blockchain**: Ethereum Sepolia Testnet
- **FHE Technology**: Zama FHEVM
- **Frontend**: Next.js, React, TypeScript
- **Wallet**: RainbowKit, MetaMask
- **Development**: Hardhat, Ethers.js

## Getting Started

### Prerequisites
- Node.js >= 20
- npm >= 7.0.0

### Installation

```bash
npm install
```

### Development

```bash
# Compile contracts
npm run compile

# Run tests
npm run test

# Start frontend development server
cd frontend && npm run dev
```

### Deployment

```bash
# Deploy contracts
npx hardhat run scripts/deploy.ts --network sepolia

# Build frontend
cd frontend && npm run build
```

## Security & Privacy

This project leverages Fully Homomorphic Encryption (FHE) to ensure:
- Participant identifiers remain confidential
- Winner selection is cryptographically secure
- Results can be verified without data exposure
- No trusted third parties required

## Documentation

For more information about FHEVM and Zama technology, visit:
- [FHEVM Documentation](https://docs.zama.ai/fhevm)
- [Zama Developer Portal](https://docs.zama.ai/)

## License

BSD-3-Clause-Clear

<!-- UI improvements documented -->
<!-- Development workflow documented -->
