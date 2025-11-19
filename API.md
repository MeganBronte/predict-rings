# FHEVM Encrypted Lucky Draw & Counter API Documentation

## Overview

This project implements fully homomorphic encrypted (FHE) smart contracts for secure lottery draws and counter operations using Zama's FHEVM technology.

## Smart Contracts

### EncryptedLuckyDraw

**Address**: Deployed per network (see deployments/)

#### Functions

##### `register(externalEuint32 encryptedIdInput, bytes inputProof) external`
- **Description**: Register for the lucky draw with an encrypted participant ID
- **Parameters**:
  - `encryptedIdInput`: FHE-encrypted participant identifier
  - `inputProof`: Zero-knowledge proof for the encrypted input
- **Requirements**: Not already registered, within participant limit

##### `drawWinner() external`
- **Description**: Execute encrypted winner selection
- **Requirements**: Only admin can call, participants must exist
- **Effects**: Randomly selects winner using encrypted operations

##### `getEncryptedWinStatus(address participant) external view returns (ebool)`
- **Description**: Get encrypted win status for a participant
- **Returns**: FHE-encrypted boolean indicating if participant won

##### View Functions
- `isRegistered(address) → bool`
- `participantCount() → uint256`
- `maxParticipants() → uint256`
- `admin() → address`
- `lastDrawTimestamp() → uint256`

#### Events

##### `ParticipantRegistered(address indexed participant, uint32 indexed index)`
Emitted when a participant successfully registers.

##### `WinnerDrawn(bytes32 randomnessCommitment, uint256 indexed participantCount)`
Emitted after winner selection with randomness commitment.

### FHECounter

**Address**: Deployed per network (see deployments/)

#### Functions

##### `increment(externalEuint32 input, bytes proof) external`
- **Description**: Increment counter by encrypted value
- **Validation**: Input range 1-1000, valid proof required

##### `decrement(externalEuint32 input, bytes proof) external`
- **Description**: Decrement counter by encrypted value
- **Validation**: Same as increment

##### `reset() external`
- **Description**: Reset counter to zero
- **Requirements**: Only contract deployer can call

##### `getCount() external view returns (euint32)`
- **Returns**: Current encrypted counter value

## Frontend Hooks

### useLuckyDraw

```typescript
const {
  state,
  register,
  drawWinner,
  decryptWinner,
  decryptMyStatus,
  decryptMyId,
  refresh,
  message,
  canUseContract
} = useLuckyDraw(params);
```

### useFHECounter

```typescript
const {
  state,
  increment,
  decrement,
  reset,
  decryptCount,
  refresh,
  message,
  canUseContract
} = useFHECounter(params);
```

## Network Deployments

### Local Development
- **Network**: Hardhat (chainId: 31337)
- **RPC**: http://127.0.0.1:8545

### Sepolia Testnet
- **Network**: Sepolia (chainId: 11155111)
- **RPC**: https://sepolia.infura.io/v3/YOUR_API_KEY

### Mainnet
- **Network**: Ethereum (chainId: 1)
- **RPC**: https://mainnet.infura.io/v3/YOUR_API_KEY

## Environment Variables

```bash
# Contract deployment
MNEMONIC="your twelve word seed phrase"
INFURA_API_KEY="your infura api key"
ETHERSCAN_API_KEY="your etherscan api key"

# Git (for development)
GIT_AUTHOR_NAME="Your Name"
GIT_AUTHOR_EMAIL="your.email@example.com"
```

## Development

```bash
# Install dependencies
npm install

# Compile contracts
npm run compile

# Run tests
npm test

# Deploy locally
npm run deploy:localhost

# Deploy to Sepolia
npm run deploy:sepolia
```

## Security Considerations

- All sensitive data remains encrypted on-chain
- Winner selection uses cryptographically secure randomness
- Zero-knowledge proofs ensure input validity
- Access controls prevent unauthorized operations
- FHE operations maintain privacy while enabling computation

## Integration Examples

See `scripts/deploy.js` for deployment automation and `frontend/hooks/` for React integration patterns.
