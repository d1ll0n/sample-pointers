pragma solidity ^0.8.17;

import "./ConsiderationItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type DynArrayConsiderationItemPointer is uint256;

using DynArrayConsiderationItemPointerLibrary for DynArrayConsiderationItemPointer global;

/// @dev Library for resolving pointers of a ConsiderationItem[]
library DynArrayConsiderationItemPointerLibrary {
  uint256 internal constant CalldataStride = 0xc0;

  /// @dev Convert a `MemoryPointer` to a `DynArrayConsiderationItemPointer`.
  ///      This adds `DynArrayConsiderationItemPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (DynArrayConsiderationItemPointer) {
    return DynArrayConsiderationItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `DynArrayConsiderationItemPointer` back into a `MemoryPointer`.
  function unwrap(DynArrayConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(DynArrayConsiderationItemPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of the array.
  ///      This points to the first item's data
  function head(DynArrayConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  /// @dev Resolve the pointer to the head of `arr[index]` in memory.
  ///      This points to the beginning of the encoded `ConsiderationItem[]`
  function element(DynArrayConsiderationItemPointer ptr, uint256 index) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset((index * CalldataStride) + 32);
  }

  /// @dev Resolve the pointer for the length of the `ConsiderationItem[]` at `ptr`.
  function length(DynArrayConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Set the length for the `ConsiderationItem[]` at `ptr` to `length`.
  function setLength(DynArrayConsiderationItemPointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  /// @dev Set the length for the `ConsiderationItem[]` at `ptr` to `type(uint256).max`.
  function setMaxLength(DynArrayConsiderationItemPointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  /// @dev Add dirty bits from 0 to 224 to the length for the `ConsiderationItem[]` at `ptr`
  function addDirtyBitsToLength(DynArrayConsiderationItemPointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the `ConsiderationItemPointer` pointing to the data buffer of `arr[index]`
  function elementData(DynArrayConsiderationItemPointer ptr, uint256 index) internal pure returns (ConsiderationItemPointer) {
    return ConsiderationItemPointerLibrary.wrap(element(ptr, index));
  }
}