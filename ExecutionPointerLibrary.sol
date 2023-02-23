pragma solidity ^0.8.17;

import "./ReceivedItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type ExecutionPointer is uint256;

using ExecutionPointerLibrary for ExecutionPointer global;

/// @dev Library for resolving pointers of a Execution
library ExecutionPointerLibrary {
  uint256 internal constant offererOffset = 0xa0;
  uint256 internal constant conduitKeyOffset = 0xc0;

  function wrap(MemoryPointer ptr) internal pure returns (ExecutionPointer) {
    return ExecutionPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(ExecutionPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(ExecutionPointer.unwrap(ptr));
  }

  function item(ExecutionPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function itemData(ExecutionPointer ptr) internal pure returns (ReceivedItemPointer) {
    return ReceivedItemPointerLibrary.wrap(item(ptr));
  }

  function offerer(ExecutionPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offererOffset);
  }

  /// Add dirty bits to `offerer`
  function addDirtyBitsToOfferer(ExecutionPointer ptr) internal pure {
    offerer(ptr).addDirtyBitsBefore(0x60);
  }

  function conduitKey(ExecutionPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(conduitKeyOffset);
  }
}