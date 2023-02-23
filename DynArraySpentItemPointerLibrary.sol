pragma solidity ^0.8.17;

import "./SpentItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type DynArraySpentItemPointer is uint256;

using DynArraySpentItemPointerLibrary for DynArraySpentItemPointer global;

/// @dev Library for resolving pointers of a SpentItem[]
library DynArraySpentItemPointerLibrary {
  uint256 internal constant CalldataStride = 0x80;

  /// @dev Convert a `MemoryPointer` to a `DynArraySpentItemPointer`.
  ///      This adds `DynArraySpentItemPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (DynArraySpentItemPointer) {
    return DynArraySpentItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `DynArraySpentItemPointer` back into a `MemoryPointer`.
  function unwrap(DynArraySpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(DynArraySpentItemPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of the array.
  ///      This points to the first item's data
  function head(DynArraySpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  /// @dev Resolve the pointer to the head of `arr[index]` in memory.
  ///      This points to the beginning of the encoded `SpentItem[]`
  function element(DynArraySpentItemPointer ptr, uint256 index) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset((index * CalldataStride) + 32);
  }

  /// @dev Resolve the pointer for the length of the `SpentItem[]` at `ptr`.
  function length(DynArraySpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Set the length for the `SpentItem[]` at `ptr` to `length`.
  function setLength(DynArraySpentItemPointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  /// @dev Set the length for the `SpentItem[]` at `ptr` to `type(uint256).max`.
  function setMaxLength(DynArraySpentItemPointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  /// @dev Add dirty bits from 0 to 224 to the length for the `SpentItem[]` at `ptr`
  function addDirtyBitsToLength(DynArraySpentItemPointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the `SpentItemPointer` pointing to the data buffer of `arr[index]`
  function elementData(DynArraySpentItemPointer ptr, uint256 index) internal pure returns (SpentItemPointer) {
    return SpentItemPointerLibrary.wrap(element(ptr, index));
  }
}