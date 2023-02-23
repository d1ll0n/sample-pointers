pragma solidity ^0.8.17;

import "./ReceivedItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type ExecutionPointer is uint256;

using ExecutionPointerLibrary for ExecutionPointer global;

/// @dev Library for resolving pointers of a Execution
/// struct Execution {
///   ReceivedItem item;
///   address offerer;
///   bytes32 conduitKey;
/// }
library ExecutionPointerLibrary {
  uint256 internal constant offererOffset = 0xa0;
  uint256 internal constant conduitKeyOffset = 0xc0;

  /// @dev Convert a `MemoryPointer` to a `ExecutionPointer`.
  ///      This adds `ExecutionPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (ExecutionPointer) {
    return ExecutionPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `ExecutionPointer` back into a `MemoryPointer`.
  function unwrap(ExecutionPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(ExecutionPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of `item` in memory.
  ///      This points to the beginning of the encoded `ReceivedItem`
  function item(ExecutionPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Resolve the `ReceivedItemPointer` pointing to the data buffer of `item`
  function itemData(ExecutionPointer ptr) internal pure returns (ReceivedItemPointer) {
    return ReceivedItemPointerLibrary.wrap(item(ptr));
  }

  /// @dev Resolve the pointer to the head of `offerer` in memory.
  ///      This points to the beginning of the encoded `address`
  function offerer(ExecutionPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offererOffset);
  }

  /// @dev Add dirty bits to `offerer`
  function addDirtyBitsToOfferer(ExecutionPointer ptr) internal pure {
    offerer(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `conduitKey` in memory.
  ///      This points to the beginning of the encoded `bytes32`
  function conduitKey(ExecutionPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(conduitKeyOffset);
  }
}