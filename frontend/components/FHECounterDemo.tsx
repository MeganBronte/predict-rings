"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { ethers } from "ethers";
import { useAccount, useChainId } from "wagmi";
import { formatDistanceToNowStrict } from "date-fns";

import { useInMemoryStorage } from "@/hooks/useInMemoryStorage";
import { useFhevm } from "@/fhevm/useFhevm";
import { useBrowserEthers } from "@/hooks/useBrowserEthers";
import { useFHECounter } from "@/hooks/useFHECounter";

const MOCK_CHAINS = { 31337: "http://127.0.0.1:8545" };

export function FHECounterDemo() {
  const { address, isConnected } = useAccount();
  const chainId = useChainId();
  const { storage } = useInMemoryStorage();
  const { provider, signer, eip1193 } = useBrowserEthers();

  const {
    instance,
    status: fhevmStatus,
    error: fhevmError,
  } = useFhevm({
    provider: eip1193,
    chainId,
    initialMockChains: MOCK_CHAINS,
    enabled: Boolean(eip1193),
  });

  const counter = useFHECounter({
    instance,
    storage,
    provider,
    signer,
  });

  const [inputValue, setInputValue] = useState<string>("1");
  const [inputError, setInputError] = useState<string | undefined>(undefined);

  const friendlyFhevmError = useMemo(() => {
    if (!fhevmError) {
      return undefined;
    }
    const raw = fhevmError.message ?? "";
    if (raw.includes("Result::unwrap_throw")) {
      return "FHE 执行环境正在恢复，请稍后点击 Refresh 再试。";
    }
    return "FHE 执行环境暂不可用，请刷新页面或重新连接钱包。";
  }, [fhevmError]);

  useEffect(() => {
    if (counter.canUseContract && (signer || provider)) {
      counter.refresh();
    }
  }, [counter.canUseContract, counter.refresh, provider, signer]);

  const validateInput = (value: string): boolean => {
    const parsed = Number(value);
    if (!Number.isInteger(parsed) || parsed < 1 || parsed > 1000) {
      setInputError("Value must be an integer between 1 and 1000.");
      return false;
    }
    setInputError(undefined);
    return true;
  };

  const handleIncrement = async () => {
    if (!validateInput(inputValue)) return;
    try {
      await counter.increment(Number(inputValue));
    } catch (error) {
      console.error("Increment error:", error);
    }
  };

  const handleDecrement = async () => {
    if (!validateInput(inputValue)) return;
    try {
      await counter.decrement(Number(inputValue));
    } catch (error) {
      console.error("Decrement error:", error);
    }
  };

  const handleReset = async () => {
    try {
      await counter.reset();
    } catch (error) {
      console.error("Reset error:", error);
    }
  };

  const disableActions = !isConnected || !counter.canUseContract;

  // Event listener setup with error handling
  useEffect(() => {
    if (!counter.canUseContract || !counter.state.contractAddress) {
      return;
    }

    let contract: any = null;
    let eventListeners: any[] = [];

    const setupEventListeners = async () => {
      try {
        if (provider) {
          contract = new ethers.Contract(
            counter.state.contractAddress,
            FHECounterABI.abi,
            provider
          );

          // Add event listeners with error handling
          const onError = (error: any) => {
            console.error("Contract event error:", error);
            setMessage("Event listening error occurred");
          };

          // Listen for any contract errors
          contract.on("error", onError);
          eventListeners.push(() => contract.off("error", onError));

          // Could add specific event listeners here if needed
          // const onSomeEvent = (value) => { ... };
          // contract.on("SomeEvent", onSomeEvent);
          // eventListeners.push(() => contract.off("SomeEvent", onSomeEvent));
        }
      } catch (error) {
        console.error("Failed to setup event listeners:", error);
        setMessage("Failed to setup contract event listeners");
      }
    };

    setupEventListeners();

    // Cleanup function
    return () => {
      if (contract) {
        eventListeners.forEach(cleanup => {
          try {
            cleanup();
          } catch (error) {
            console.error("Error cleaning up event listener:", error);
          }
        });
      }
    };
  }, [counter.canUseContract, counter.state.contractAddress, provider]);

  return (
    <div className="flex flex-col gap-6">
      <div className="card-surface p-6">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-2xl font-semibold">FHE Counter Demo</h2>
          <button
            type="button"
            className="rounded-full border border-slate-200 px-4 py-2 text-sm font-medium text-slate-600 transition hover:bg-slate-100 disabled:opacity-50"
            onClick={counter.refresh}
            disabled={disableActions || counter.isRefreshing}
          >
            {counter.isRefreshing ? "Refreshing..." : "Refresh"}
          </button>
        </div>

        <div className="space-y-4">
          <div className="text-center">
            <p className="text-6xl font-bold text-indigo-600">
              {counter.decryptedCount ?? "–"}
            </p>
            <p className="text-sm text-slate-500">Current Count</p>
          </div>

          <dl className="grid gap-3 text-sm text-slate-600">
            <div className="flex justify-between rounded-2xl bg-slate-50 px-4 py-3">
              <dt className="font-medium text-slate-500">FHEVM status</dt>
              <dd className="font-semibold text-slate-800">{fhevmStatus}</dd>
            </div>
            <div className="flex justify-between rounded-2xl bg-slate-50 px-4 py-3">
              <dt className="font-medium text-slate-500">Contract</dt>
              <dd className="font-mono text-xs text-slate-500">
                {counter.state.contractAddress ?? "Not deployed"}
              </dd>
            </div>
          </dl>

          {friendlyFhevmError && (
            <p className="rounded-2xl border border-amber-200 bg-amber-50 px-4 py-3 text-sm text-amber-700">
              {friendlyFhevmError}
            </p>
          )}

          {counter.message && (
            <p className="rounded-2xl border border-blue-200 bg-blue-50 px-4 py-3 text-sm text-blue-700">
              {counter.message}
            </p>
          )}

          <div className="space-y-3">
            <label className="text-sm font-medium text-slate-600">
              Operation Value
            </label>
            <input
              type="number"
              value={inputValue}
              onChange={(e) => {
                setInputValue(e.target.value);
                if (inputError) validateInput(e.target.value);
              }}
              placeholder="Enter value (1-1000)"
              className="w-full rounded-lg border border-slate-300 bg-white px-3 py-2 text-sm shadow-inner focus:border-indigo-400 focus:outline-none"
              disabled={disableActions}
              min={1}
              max={1000}
            />
            {inputError && <p className="text-sm text-rose-500">{inputError}</p>}
          </div>

          <div className="grid grid-cols-3 gap-2">
            <button
              onClick={handleIncrement}
              disabled={disableActions || counter.isIncrementing}
              className="rounded-lg bg-green-600 px-4 py-3 text-sm font-semibold text-white shadow-md transition hover:bg-green-700 disabled:opacity-60"
            >
              {counter.isIncrementing ? "Incrementing..." : "Increment"}
            </button>
            <button
              onClick={handleDecrement}
              disabled={disableActions || counter.isDecrementing}
              className="rounded-lg bg-red-600 px-4 py-3 text-sm font-semibold text-white shadow-md transition hover:bg-red-700 disabled:opacity-60"
            >
              {counter.isDecrementing ? "Decrementing..." : "Decrement"}
            </button>
            <button
              onClick={handleReset}
              disabled={disableActions || counter.isResetting}
              className="rounded-lg bg-slate-600 px-4 py-3 text-sm font-semibold text-white shadow-md transition hover:bg-slate-800 disabled:opacity-60"
            >
              {counter.isResetting ? "Resetting..." : "Reset"}
            </button>
          </div>

          <div className="rounded-lg border border-slate-200 bg-white p-4 text-sm text-slate-600 shadow-inner">
            <p className="mb-2 font-semibold">How it works:</p>
            <ul className="space-y-1 text-xs">
              <li>• Values are encrypted locally before sending to the blockchain</li>
              <li>• All operations maintain privacy through FHE</li>
              <li>• Only you can decrypt and view the actual counter value</li>
              <li>• Reset operation requires contract deployer permission</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
}