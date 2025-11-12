// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {FHE, euint32, externalEuint32} from "@fhevm/solidity/lib/FHE.sol";
import {SepoliaConfig} from "@fhevm/solidity/config/ZamaConfig.sol";

/// @title A simple FHE counter contract
contract FHECounter is SepoliaConfig {
    address private immutable _deployer;
    euint32 private _count;

    constructor() {
        _deployer = msg.sender;
    }

    /// @notice Returns the current count
    function getCount() external view returns (euint32) {
        return _count;
    }

    /// @notice Increments the counter by a specified encrypted value.
    /// @dev This example omits overflow/underflow checks for simplicity and readability.
    /// In a production contract, proper range checks should be implemented.
    function increment(externalEuint32 inputEuint32, bytes calldata inputProof) external {
        // Validate input proof and encrypted value
        require(inputProof.length > 0, "Invalid input proof");
        euint32 encryptedEuint32 = FHE.fromExternal(inputEuint32, inputProof);

        // Ensure the encrypted value is within reasonable bounds (0 < value <= 1000)
        ebool isValidRange = FHE.and(
            FHE.gt(encryptedEuint32, FHE.asEuint32(0)),
            FHE.le(encryptedEuint32, FHE.asEuint32(1000))
        );
        require(FHE.decrypt(isValidRange), "Increment value must be between 1 and 1000");

        _count = FHE.add(_count, encryptedEuint32);

        FHE.allowThis(_count);
        FHE.allow(_count, msg.sender);
    }

    /// @notice Decrements the counter by a specified encrypted value.
    /// @dev This example omits overflow/underflow checks for simplicity and readability.
    /// In a production contract, proper range checks should be implemented.
    function decrement(externalEuint32 inputEuint32, bytes calldata inputProof) external {
        euint32 encryptedEuint32 = FHE.fromExternal(inputEuint32, inputProof);

        _count = FHE.sub(_count, encryptedEuint32);

        FHE.allowThis(_count);
        FHE.allow(_count, msg.sender);
    }

    /// @notice Resets the counter to zero.
    /// @dev Only allows the contract deployer to reset the counter.
    function reset() external {
        require(msg.sender == _deployer, "Only deployer can reset");
        _count = FHE.asEuint32(0);
        FHE.allowThis(_count);
    }
}
