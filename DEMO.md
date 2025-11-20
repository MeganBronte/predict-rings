# 🎯 Interactive Demo Guide

## Live Demonstration Steps

### Step 1: Environment Setup
```bash
# Start local blockchain
npm run deploy:localhost

# Launch frontend
cd frontend && npm run dev

# Open http://localhost:3000
```

### Step 2: Wallet Connection
- Click "Connect Wallet" in the top-right corner
- Select MetaMask or any Web3-compatible wallet
- Ensure you're connected to localhost:8545

### Step 3: FHE Counter Demo
1. Navigate to the counter section
2. Enter a value (1-1000) in the input field
3. Click "Increment" to add to the encrypted counter
4. Click "Decrement" to subtract from the counter
5. Click "Decrypt Count" to view the actual value locally
6. Try "Reset" (only works for contract deployer)

### Step 4: Encrypted Lucky Draw Demo
1. Switch to the Lucky Draw section
2. Enter any numeric participant ID
3. Click "Encrypt & Register" to join the lottery
4. Wait for other participants or add multiple accounts
5. As admin/deployer, click "Run Encrypted Draw"
6. Click "Decrypt Winner Index" to see the result
7. Each participant can "Decrypt My Result" privately

## 🎬 Demo Video Highlights

### Key Features Demonstrated:
- **🔐 Privacy Preservation**: All operations happen on encrypted data
- **⚡ Real-time Updates**: Live blockchain state synchronization
- **🔒 Secure Operations**: Zero-knowledge proof validation
- **👥 Multi-user Simulation**: Multiple wallet interactions
- **📊 State Management**: Comprehensive UI state handling

### Technical Implementation:
- FHEVM contract deployments
- React hooks for blockchain interaction
- Encrypted input handling
- Signature-based decryption
- Error boundary protection

## 🧪 Test Scenarios

### Counter Operations
```javascript
// Increment by 5
await counter.increment(5);

// Decrement by 3
await counter.decrement(3);

// Reset (admin only)
await counter.reset();
```

### Lottery Flow
```javascript
// Register participant
await luckyDraw.register(42);

// Execute draw (admin)
await luckyDraw.drawWinner();

// Decrypt results
const winner = await luckyDraw.decryptWinner();
const myResult = await luckyDraw.decryptMyStatus();
```

## 🔍 Troubleshooting

### Common Issues:
- **"FHEVM instance not ready"**: Wait for page to fully load
- **"Contract not deployed"**: Run deployment script first
- **"Not authorized"**: Use the correct admin wallet
- **Transaction failed**: Check wallet balance and gas settings

### Performance Tips:
- Use local Hardhat node for fastest experience
- Close other browser tabs during demo
- Ensure stable internet connection
- Clear browser cache if experiencing issues

## 📈 Demo Metrics

- **Transaction Speed**: < 3 seconds on localhost
- **Encryption Time**: < 1 second for input encryption
- **Decryption Time**: Instant (client-side only)
- **UI Responsiveness**: Real-time state updates
- **Error Recovery**: Graceful failure handling

## 🎯 Next Steps

After completing this demo, explore:
- [API Documentation](./API.md)
- [Contract Source Code](./contracts/)
- [Frontend Implementation](./frontend/)
- [Test Suite](./test/)

---

*This demo showcases the future of privacy-preserving blockchain applications using FHEVM technology.*
