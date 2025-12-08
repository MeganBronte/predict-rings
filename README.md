# 🔐 FHEVM Encrypted Lucky Draw & Counter

> A privacy-preserving blockchain application featuring encrypted lottery draws and fully homomorphic counter operations using Zama's FHEVM technology.

[![Live Demo](https://img.shields.io/badge/Live_Demo-Deployed-blue?style=for-the-badge&logo=vercel)](https://predict-rings-aiyz.vercel.app/)
[![Watch Demo](https://img.shields.io/badge/Watch_Demo_Video-red?style=for-the-badge&logo=youtube)](https://github.com/MeganBronte/predict-rings/blob/main/prediction.mp4)

**Live Demo**: https://predict-rings-aiyz.vercel.app/

**Demo Video**: [Watch on GitHub](https://github.com/MeganBronte/predict-rings/blob/main/prediction.mp4)

## 🌟 Overview

This project implements two groundbreaking applications using Fully Homomorphic Encryption (FHE) on Ethereum:

### 🎰 Encrypted Lucky Draw
A privacy-preserving lottery system where:
- Participants register with encrypted identifiers
- Winners are selected using cryptographically secure encrypted randomness
- Results can be privately verified without revealing personal data
- All operations maintain complete privacy through FHE

### 🔢 FHE Counter
A fully homomorphic encrypted counter that supports:
- Encrypted increment and decrement operations
- Private computation without decrypting data
- Secure access controls for administrative functions

## 🚀 Live Deployment

### Frontend Application
- **URL**: https://predict-rings-aiyz.vercel.app/
- **Status**: ✅ Deployed and Live
- **Framework**: Next.js 14 with TypeScript
- **Styling**: Tailwind CSS

### Testnet Contracts (Sepolia)

#### EncryptedLuckyDraw
- **Address**: [`0x11928ddd7c75ae5a1Bc7d384c5e1433E2fD1Ed87`](https://sepolia.etherscan.io/address/0x11928ddd7c75ae5a1Bc7d384c5e1433E2fD1Ed87)
- **Network**: Ethereum Sepolia Testnet
- **Block Explorer**: [View on Etherscan](https://sepolia.etherscan.io/address/0x11928ddd7c75ae5a1Bc7d384c5e1433E2fD1Ed87)

#### FHECounter
- **Address**: [`0xB8d1d99c387431909c821dE9f92A476FC3A33Bd2`](https://sepolia.etherscan.io/address/0xB8d1d99c387431909c821dE9f92A476FC3A33Bd2)
- **Network**: Ethereum Sepolia Testnet
- **Block Explorer**: [View on Etherscan](https://sepolia.etherscan.io/address/0xB8d1d99c387431909c821dE9f92A476FC3A33Bd2)

## ✨ Key Features

### 🔒 Privacy by Design
- **Zero-Knowledge Participation**: Register without revealing identity
- **Encrypted Computations**: All operations on encrypted data
- **Private Verification**: Verify results without data exposure
- **FHE-Powered**: Uses Zama's production-ready FHEVM

### 🎯 Cryptographically Secure
- **Verifiable Randomness**: Blockchain-based entropy generation
- **Tamper-Proof**: Immutable smart contract logic
- **Fair Selection**: Encrypted winner determination
- **Audit-Ready**: Security-focused implementation

### 🛠️ Developer-Friendly
- **Type-Safe**: Full TypeScript integration
- **Modular Architecture**: Clean separation of concerns
- **Comprehensive Testing**: Automated test suites
- **Production Ready**: CI/CD pipeline included

## 🏗️ Architecture

```
├── 📁 contracts/           # Solidity smart contracts
│   ├── EncryptedLuckyDraw.sol    # Privacy-preserving lottery
│   └── FHECounter.sol           # Encrypted counter operations
├── 📁 frontend/            # Next.js React application
│   ├── 🎨 components/      # UI components (Dashboard, Counter)
│   ├── 🔗 hooks/          # Custom blockchain interaction hooks
│   ├── 📱 app/            # Next.js app router pages
│   └── 🎯 fhevm/          # FHEVM integration utilities
├── 📁 scripts/            # Deployment and utility scripts
├── 📁 test/               # Comprehensive test suites
└── 📁 types/              # Generated TypeScript definitions
```

## 🚀 Quick Start

### Prerequisites
- Node.js 20+
- npm or yarn
- MetaMask or compatible Web3 wallet

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

### Local Development

```bash
# Start Hardhat local blockchain
npm run deploy:localhost

# In another terminal, start the frontend
cd frontend && npm run dev

# Access at http://localhost:3000
```

### Contract Deployment

```bash
# Compile contracts
npm run compile

# Run tests
npm test

# Deploy to Sepolia testnet
npm run deploy:sepolia

# Verify contracts on Etherscan
npm run verify:sepolia
```

## 🎮 Usage Guide

### For Lottery Participants

1. **Connect Wallet**: Click "Connect Wallet" and select MetaMask
2. **Register**: Enter any numeric ID and click "Encrypt & Register"
3. **Wait**: Administrator triggers the lottery draw
4. **Verify**: Click "Decrypt My Result" to privately check if you won

### For Lottery Administrators

1. **Connect Admin Wallet**: Use the contract deployer wallet
2. **Trigger Draw**: Click "Run Encrypted Draw" to execute lottery
3. **Monitor**: View real-time statistics and participant count

### FHE Counter Operations

1. **Connect Wallet**: Link your Web3 wallet
2. **Increment/Decrement**: Enter value and click operations
3. **Reset**: Admin can reset counter to zero
4. **Decrypt**: View actual counter value locally

## 🔧 Configuration

### Environment Variables

Create `.env` file in root directory:

```bash
# Wallet configuration
MNEMONIC="your twelve word seed phrase"

# API Keys
INFURA_API_KEY="your_infura_api_key"
ETHERSCAN_API_KEY="your_etherscan_api_key"
```

### Network Configuration

The application supports multiple networks with automatic contract detection.

## 🧪 Testing

```bash
# Run all contract tests
npm test

# Run specific component tests
npm run test:fheCounter
npm run test:luckyDraw

# Generate coverage reports
npm run coverage
```

## 🔐 Security Considerations

- **FHE Implementation**: Uses Zama's battle-tested FHEVM
- **Access Controls**: Strict permission systems for admin functions
- **Input Validation**: Comprehensive validation of encrypted inputs
- **Privacy Preservation**: Zero data leakage during operations

## 📚 Technical Details

### FHEVM Integration
- **Zama FHEVM**: Production-ready FHE on Ethereum
- **Encrypted Operations**: All sensitive computations remain encrypted
- **Local Decryption**: Results decrypted client-side only

### Smart Contract Architecture
- **EncryptedLuckyDraw**: Privacy-preserving lottery with encrypted winner selection
- **FHECounter**: Homomorphic counter supporting encrypted arithmetic
- **Security Audits**: Code designed for security review and audit

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes with tests
4. Commit changes (`git commit -m 'Add amazing feature'`)
5. Push and create Pull Request

## 📄 License

This project is licensed under the BSD-3-Clause-Clear License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Zama** for the groundbreaking FHEVM technology
- **Ethereum Foundation** for the robust blockchain infrastructure
- **Vercel** for seamless frontend deployment
- **OpenZeppelin** for secure smart contract patterns

---

**Built with ❤️ using FHEVM, Next.js, TypeScript, and Tailwind CSS**

**🎬 [Watch Demo Video](https://github.com/MeganBronte/predict-rings/blob/main/prediction.mp4) | 🌐 [Live Demo](https://predict-rings-aiyz.vercel.app/)**