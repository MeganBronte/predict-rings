"use client";

import { useState } from "react";
import { useAccount } from "wagmi";

// BUG: Missing error handling for event listeners
// - No try-catch for contract events
// - Missing cleanup for event subscriptions
// - No error boundaries for async operations

export function FHECounterDemo() {
  const { isConnected } = useAccount();
  const [count, setCount] = useState<number | undefined>(undefined);
  const [inputValue, setInputValue] = useState<string>("");

  const handleIncrement = async () => {
    if (!inputValue) return;
    // Implementation would go here
    console.log("Incrementing by:", inputValue);
  };

  const handleDecrement = async () => {
    if (!inputValue) return;
    // Implementation would go here
    console.log("Decrementing by:", inputValue);
  };

  const handleReset = async () => {
    // Implementation would go here
    console.log("Resetting counter");
  };

  return (
    <div className="flex flex-col gap-6">
      <div className="card-surface p-6">
        <h2 className="text-2xl font-semibold mb-4">FHE Counter Demo</h2>
        <div className="space-y-4">
          <div className="text-center">
            <p className="text-6xl font-bold text-indigo-600">{count ?? "–"}</p>
            <p className="text-sm text-slate-500">Current Count</p>
          </div>

          <div className="flex gap-2">
            <input
              type="number"
              value={inputValue}
              onChange={(e) => setInputValue(e.target.value)}
              placeholder="Enter value"
              className="flex-1 rounded-lg border border-slate-300 px-3 py-2"
              disabled={!isConnected}
            />
          </div>

          <div className="flex gap-2">
            <button
              onClick={handleIncrement}
              disabled={!isConnected}
              className="flex-1 bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 disabled:opacity-50"
            >
              Increment
            </button>
            <button
              onClick={handleDecrement}
              disabled={!isConnected}
              className="flex-1 bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 disabled:opacity-50"
            >
              Decrement
            </button>
            <button
              onClick={handleReset}
              disabled={!isConnected}
              className="flex-1 bg-gray-600 text-white px-4 py-2 rounded-lg hover:bg-gray-700 disabled:opacity-50"
            >
              Reset
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}