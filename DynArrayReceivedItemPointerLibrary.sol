pragma solidity ^0.8.17;

import "./ReceivedItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type DynArrayReceivedItemPointer is uint256;

using DynArrayReceivedItemPointerLibrary for DynArrayReceivedItemPointer global;

/// @dev Library for resolving pointers of a ReceivedItem[]
library DynArrayReceivedItemPointerLibrary {
  uint256 internal constant CalldataStride = 0xa0;

  /// @dev Convert a `MemoryPointer` to a `DynArrayReceivedItemPointer`.
  ///      This adds `DynArrayReceivedItemPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (DynArrayReceivedItemPointer) {
    return DynArrayReceivedItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `DynArrayReceivedItemPointer` back into a `MemoryPointer`.
  function unwrap(DynArrayReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(DynArrayReceivedItemPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of the array.
  ///      This points to the first item's data
  function head(DynArrayReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  /// @dev Resolve the pointer to the head of `arr[index]` in memory.
  ///      This points to the beginning of the encoded `ReceivedItem[]`
  function element(DynArrayReceivedItemPointer ptr, uint256 index) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset((index * CalldataStride) + 32);
  }

  /// @dev Resolve the pointer for the length of the `ReceivedItem[]` at `ptr`.
  function length(DynArrayReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Set the length for the `ReceivedItem[]` at `ptr` to `length`.
  function setLength(DynArrayReceivedItemPointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  /// @dev Set the length for the `ReceivedItem[]` at `ptr` to `type(uint256).max`.
  function setMaxLength(DynArrayReceivedItemPointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  /// @dev Add dirty bits from 0 to 224 to the length for the `ReceivedItem[]` at `ptr`
  function addDirtyBitsToLength(DynArrayReceivedItemPointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the `ReceivedItemPointer` pointing to the data buffer of `arr[index]`
  function elementData(DynArrayReceivedItemPointer ptr, uint256 index) internal pure returns (ReceivedItemPointer) {
    return ReceivedItemPointerLibrary.wrap(element(ptr, index));
  }
}