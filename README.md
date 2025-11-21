# FHEVM Encrypted Lucky Draw & Counter

A privacy-preserving lottery and counter application using Fully Homomorphic Encryption (FHE) on Zama's FHEVM.

## Contracts

### EncryptedLuckyDraw
A privacy-preserving lottery system where participants register with encrypted identifiers and winners are determined using encrypted randomness.

### FHECounter
A simple fully homomorphic encrypted counter that allows incrementing and decrementing encrypted values while maintaining privacy.

## Features

- **Privacy-First**: All sensitive data is encrypted using FHEVM
- **Verifiable**: Participants can verify lottery results without revealing their identity
- **Secure**: Only contract deployer can trigger draws and reset operations

## Quick Start

```bash
# Install dependencies
npm install
cd frontend && npm install && cd ..

# Start local development
npx hardhat node

# Deploy contracts
npm run deploy:localhost

# Start frontend
cd frontend && npm run dev
```

## Development

```bash
# Compile contracts
npm run compile

# Run tests
npm test

# Deploy to testnet
npm run deploy:sepolia
```

## License

BSD-3-Clause-Clear