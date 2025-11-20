# 🔐 FHEVM Encrypted Lucky Draw & Counter

> A comprehensive blockchain application featuring privacy-preserving lottery draws and encrypted counters using Fully Homomorphic Encryption (FHE) on Zama's FHEVM.

![Demo Video](prediction.mp4)

## 🌟 Overview

This project demonstrates the power of privacy-preserving blockchain applications through two interconnected dApps:

1. **🎰 Encrypted Lucky Draw**: A fair lottery system where participants register with encrypted IDs and winners are selected using encrypted randomness
2. **🔢 FHE Counter**: A privacy-preserving counter that supports encrypted increment/decrement operations

Built on Zama's FHEVM technology, this application ensures that sensitive data never leaves encrypted state while still enabling complex computations.

## ✨ Key Features

### 🔒 Privacy by Design
- **Zero-Knowledge Participation**: Register for lotteries without revealing your identity
- **Encrypted Computations**: All operations happen on encrypted data
- **Private Verification**: Check results without exposing personal information

### 🎯 Fair & Transparent
- **Cryptographically Secure**: Winner selection uses blockchain randomness
- **Verifiable Results**: Anyone can verify lottery fairness without seeing participant data
- **Tamper-Proof**: Smart contract logic ensures immutable rules

### 🚀 Developer-Friendly
- **Type-Safe**: Full TypeScript integration with generated contract types
- **Modular Architecture**: Clean separation between contracts, frontend, and utilities
- **Comprehensive Testing**: Extensive test suite with 100% coverage goals

## 🏗️ Architecture

```
├── contracts/           # Solidity smart contracts
│   ├── EncryptedLuckyDraw.sol
│   └── FHECounter.sol
├── frontend/            # Next.js React application
│   ├── components/      # Reusable UI components
│   ├── hooks/          # Custom React hooks for blockchain interaction
│   └── app/            # Next.js app router pages
├── scripts/            # Deployment and utility scripts
├── test/               # Comprehensive test suite
└── types/              # Generated TypeScript types
```

### Smart Contracts

#### EncryptedLuckyDraw
- **Privacy-Preserving Registration**: Participants submit encrypted identifiers
- **Encrypted Winner Selection**: Random selection using on-chain entropy
- **Private Result Verification**: Participants decrypt their win status locally
- **Admin Controls**: Deployer manages lottery execution

#### FHECounter
- **Encrypted Arithmetic**: Increment/decrement operations on encrypted values
- **Input Validation**: Range checking and proof verification
- **Access Control**: Deployer-only reset functionality

## 🚀 Quick Start

### Prerequisites
- Node.js 20+
- npm or yarn
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/MeganBronte/predict-rings.git
cd predict-rings

# Install dependencies
npm install

# Install frontend dependencies
cd frontend && npm install && cd ..
```

### Development

```bash
# Start local Hardhat node
npx hardhat node

# Deploy contracts locally
npm run deploy:localhost

# Start frontend development server
cd frontend && npm run dev

# Run tests
npm test
```

### Deployment

```bash
# Deploy to Sepolia testnet
npm run deploy:sepolia

# Verify contracts on Etherscan
npm run verify:sepolia
```

## 📖 Usage Guide

### For Participants

1. **Connect Wallet**: Use MetaMask or any Web3 wallet
2. **Register**: Choose any numeric ID and encrypt it locally
3. **Wait for Draw**: Admin triggers the lottery using encrypted randomness
4. **Verify Results**: Decrypt your win status privately

### For Administrators

1. **Deploy Contract**: Set maximum participants limit
2. **Monitor Registration**: Track participant count
3. **Trigger Draw**: Execute winner selection
4. **Manage Lottery**: Reset for new rounds if needed

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:

```bash
# Wallet configuration
MNEMONIC="your twelve word seed phrase"

# API Keys
INFURA_API_KEY="your_infura_api_key"
ETHERSCAN_API_KEY="your_etherscan_api_key"

# Git (optional, for development)
GIT_AUTHOR_NAME="Your Name"
GIT_AUTHOR_EMAIL="your.email@example.com"
```

### Network Configuration

The project supports multiple networks:

- **Local**: Hardhat development network
- **Sepolia**: Ethereum testnet for testing
- **Mainnet**: Production Ethereum network

## 🧪 Testing

```bash
# Run all tests
npm test

# Run specific contract tests
npm run test:fheCounter
npm run test:luckyDraw

# Generate coverage report
npm run coverage
```

## 🔐 Security Considerations

- **FHE Implementation**: All sensitive operations use Zama's battle-tested FHEVM
- **Access Controls**: Strict permission systems for admin operations
- **Input Validation**: Comprehensive validation of encrypted inputs
- **Audit Ready**: Code follows Solidity best practices and security patterns

## 📚 API Reference

Detailed API documentation available in [API.md](./API.md)

### Key Functions

#### EncryptedLuckyDraw
- `register(externalEuint32, bytes)` - Register with encrypted ID
- `drawWinner()` - Execute lottery draw (admin only)
- `getEncryptedWinStatus(address)` - Get encrypted result

#### FHECounter
- `increment(externalEuint32, bytes)` - Add to encrypted counter
- `decrement(externalEuint32, bytes)` - Subtract from encrypted counter
- `reset()` - Reset counter to zero (deployer only)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow existing code style and patterns
- Add comprehensive tests for new features
- Update documentation for API changes
- Ensure all CI checks pass

## 📄 License

This project is licensed under the BSD-3-Clause-Clear License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Zama** for the groundbreaking FHEVM technology
- **Ethereum Foundation** for the robust blockchain infrastructure
- **OpenZeppelin** for secure smart contract patterns

## 📞 Support

- **Documentation**: [FHEVM Docs](https://docs.zama.ai/fhevm)
- **Issues**: [GitHub Issues](https://github.com/MeganBronte/predict-rings/issues)
- **Discussions**: [GitHub Discussions](https://github.com/MeganBronte/predict-rings/discussions)

---

**Built with ❤️ using FHEVM, Next.js, and TypeScript**
