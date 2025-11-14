"use client";

import { useCallback, useMemo, useRef, useState } from "react";
import { ethers } from "ethers";
import { useAccount, useChainId } from "wagmi";

import { FhevmInstance } from "@/fhevm/fhevmTypes";
import { FhevmDecryptionSignature } from "@/fhevm/FhevmDecryptionSignature";
import { GenericStringStorage } from "@/fhevm/GenericStringStorage";
import { FHECounterABI } from "@/abi/FHECounterABI";
import { FHECounterAddresses } from "@/abi/FHECounterAddresses";

type UseFHECounterParams = {
  instance: FhevmInstance | undefined;
  storage: GenericStringStorage;
  provider: ethers.BrowserProvider | undefined;
  signer: ethers.JsonRpcSigner | undefined;
};

function isUserRejectedError(error: unknown): boolean {
  if (!error || typeof error !== "object") {
    return false;
  }

  const codePaths = [
    (error as { code?: string | number }).code,
    (error as { error?: { code?: string | number } }).error?.code,
    (error as { info?: { error?: { code?: string | number } } }).info?.error?.code,
  ];

  return codePaths.some((code) => code === 4001 || code === "ACTION_REJECTED");
}

function getDeploymentByChainId(chainId: number | undefined) {
  if (chainId === undefined) {
    return undefined;
  }

  const entry = FHECounterAddresses[
    chainId.toString() as keyof typeof FHECounterAddresses
  ];

  if (!entry || !("address" in entry)) {
    return undefined;
  }

  return entry as {
    address: `0x${string}`;
    chainId: number;
    chainName: string;
  };
}

export function useFHECounter({
  instance,
  storage,
  provider,
  signer,
}: UseFHECounterParams) {
  const { address, isConnected } = useAccount();
  const chainId = useChainId();

  const [state, setState] = useState<{
    contractAddress?: `0x${string}`;
    isDeployed: boolean;
    countHandle?: string;
  }>({
    isDeployed: false,
    contractAddress: undefined,
    countHandle: undefined,
  });

  const [message, setMessage] = useState<string>("");
  const [isRefreshing, setIsRefreshing] = useState(false);
  const [isIncrementing, setIsIncrementing] = useState(false);
  const [isDecrementing, setIsDecrementing] = useState(false);
  const [isResetting, setIsResetting] = useState(false);
  const [decryptedCount, setDecryptedCount] = useState<number | undefined>(undefined);

  const contractInfo = useMemo(() => getDeploymentByChainId(chainId), [chainId]);
  const canUseContract = Boolean(contractInfo?.address && contractInfo.address !== ethers.ZeroAddress);

  const contractRef = useRef<ethers.Contract | null>(null);

  const getReadonlyContract = useCallback(() => {
    if (!contractInfo?.address) {
      return null;
    }
    if (contractRef.current && contractRef.current.target === contractInfo.address) {
      return contractRef.current;
    }
    const runner = signer ?? provider;
    if (!runner) {
      return null;
    }
    const contract = new ethers.Contract(
      contractInfo.address,
      FHECounterABI.abi,
      runner,
    );
    contractRef.current = contract;
    return contract;
  }, [contractInfo?.address, provider, signer]);

  const refresh = useCallback(async () => {
    if (!canUseContract) {
      setState((prev) => ({
        ...prev,
        contractAddress: undefined,
        isDeployed: false,
        countHandle: undefined,
      }));
      return;
    }

    const contract = getReadonlyContract();
    if (!contract) {
      return;
    }

    setIsRefreshing(true);
    setMessage("Refreshing FHE counter state...");

    try {
      const count = await contract.getCount();
      setState({
        contractAddress: contractInfo?.address,
        isDeployed: true,
        countHandle: count,
      });
      setMessage("Counter state refreshed.");
    } catch (error) {
      console.error(error);
      setMessage("Failed to refresh counter state.");
    } finally {
      setIsRefreshing(false);
    }
  }, [address, canUseContract, contractInfo?.address, getReadonlyContract]);

  const requireSigner = useCallback(() => {
    if (!signer || !address) {
      throw new Error("Connect wallet to continue.");
    }
    if (!state.contractAddress) {
      throw new Error("Contract not deployed on this network.");
    }
    if (!instance) {
      throw new Error("FHEVM instance not ready.");
    }
  }, [address, instance, signer, state.contractAddress]);

  const increment = useCallback(
    async (value: number) => {
      requireSigner();
      if (!instance || !signer || !state.contractAddress) {
        return;
      }

      setIsIncrementing(true);
      setMessage("Preparing encrypted increment...");

      try {
        const input = instance.createEncryptedInput(
          state.contractAddress,
          signer.address,
        );
        input.add32(value);
        const encrypted = await input.encrypt();

        const contract = new ethers.Contract(
          state.contractAddress,
          FHECounterABI.abi,
          signer,
        );

        const tx = await contract.increment(
          encrypted.handles[0],
          encrypted.inputProof,
        );
        await tx.wait();
        setMessage("Counter incremented. Refreshing state...");
        await refresh();
      } catch (error) {
        if (isUserRejectedError(error)) {
          setMessage("Increment cancelled in wallet.");
        } else {
          console.error(error);
          setMessage("Increment failed.");
        }
      } finally {
        setIsIncrementing(false);
      }
    },
    [instance, refresh, requireSigner, signer, state.contractAddress],
  );

  const decrement = useCallback(
    async (value: number) => {
      requireSigner();
      if (!instance || !signer || !state.contractAddress) {
        return;
      }

      setIsDecrementing(true);
      setMessage("Preparing encrypted decrement...");

      try {
        const input = instance.createEncryptedInput(
          state.contractAddress,
          signer.address,
        );
        input.add32(value);
        const encrypted = await input.encrypt();

        const contract = new ethers.Contract(
          state.contractAddress,
          FHECounterABI.abi,
          signer,
        );

        const tx = await contract.decrement(
          encrypted.handles[0],
          encrypted.inputProof,
        );
        await tx.wait();
        setMessage("Counter decremented. Refreshing state...");
        await refresh();
      } catch (error) {
        if (isUserRejectedError(error)) {
          setMessage("Decrement cancelled in wallet.");
        } else {
          console.error(error);
          setMessage("Decrement failed.");
        }
      } finally {
        setIsDecrementing(false);
      }
    },
    [instance, refresh, requireSigner, signer, state.contractAddress],
  );

  const reset = useCallback(async () => {
    requireSigner();
    if (!signer || !state.contractAddress) {
      return;
    }

    setIsResetting(true);
    setMessage("Resetting counter to zero...");

    try {
      const contract = new ethers.Contract(
        state.contractAddress,
        FHECounterABI.abi,
        signer,
      );
      const tx = await contract.reset();
      await tx.wait();
      setMessage("Counter reset. Refreshing state...");
      await refresh();
    } catch (error) {
      if (isUserRejectedError(error)) {
        setMessage("Reset cancelled in wallet.");
      } else {
        console.error(error);
        setMessage("Reset failed.");
      }
    } finally {
      setIsResetting(false);
    }
  }, [refresh, requireSigner, signer, state.contractAddress]);

  const decryptCount = useCallback(async () => {
    requireSigner();
    if (!state.countHandle || state.countHandle === ethers.ZeroHash) {
      setMessage("No counter value to decrypt.");
      return;
    }
    if (!instance || !state.contractAddress || !signer) {
      return;
    }

    setMessage("Decrypting counter value...");

    try {
      const signature = await FhevmDecryptionSignature.loadOrSign(
        instance,
        [state.contractAddress],
        signer,
        storage,
      );
      if (!signature) {
        throw new Error("Unable to generate decryption signature.");
      }

      const decrypted = await instance.userDecrypt(
        [
          {
            handle: state.countHandle,
            contractAddress: state.contractAddress,
          },
        ],
        signature.privateKey,
        signature.publicKey,
        signature.signature,
        signature.contractAddresses,
        signature.userAddress,
        signature.startTimestamp,
        signature.durationDays,
      );

      const value = decrypted[state.countHandle];
      const numericValue =
        typeof value === "bigint"
          ? Number(value)
          : typeof value === "number"
            ? value
            : Number(value ?? 0);

      setDecryptedCount(numericValue);
      setMessage("Counter value decrypted locally.");
    } catch (error) {
      console.error(error);
      setMessage("Failed to decrypt counter value.");
    }
  }, [instance, requireSigner, signer, state.contractAddress, state.countHandle, storage]);

  return {
    state,
    refresh,
    increment,
    decrement,
    reset,
    decryptCount,
    message,
    isRefreshing,
    isIncrementing,
    isDecrementing,
    isResetting,
    decryptedCount,
    canUseContract,
    isConnected,
  };
}