pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type DynArrayBytes32Pointer is uint256;

using DynArrayBytes32PointerLibrary for DynArrayBytes32Pointer global;

/// @dev Library for resolving pointers of a bytes32[]
library DynArrayBytes32PointerLibrary {
  uint256 internal constant CalldataStride = 0x20;

  /// @dev Convert a `MemoryPointer` to a `DynArrayBytes32Pointer`.
  ///      This adds `DynArrayBytes32PointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (DynArrayBytes32Pointer) {
    return DynArrayBytes32Pointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `DynArrayBytes32Pointer` back into a `MemoryPointer`.
  function unwrap(DynArrayBytes32Pointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(DynArrayBytes32Pointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of the array.
  ///      This points to the first item's data
  function head(DynArrayBytes32Pointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  /// @dev Resolve the pointer to the head of `arr[index]` in memory.
  ///      This points to the beginning of the encoded `bytes32[]`
  function element(DynArrayBytes32Pointer ptr, uint256 index) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset((index * CalldataStride) + 32);
  }

  /// @dev Resolve the pointer for the length of the `bytes32[]` at `ptr`.
  function length(DynArrayBytes32Pointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Set the length for the `bytes32[]` at `ptr` to `length`.
  function setLength(DynArrayBytes32Pointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  /// @dev Set the length for the `bytes32[]` at `ptr` to `type(uint256).max`.
  function setMaxLength(DynArrayBytes32Pointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  /// @dev Add dirty bits from 0 to 224 to the length for the `bytes32[]` at `ptr`
  function addDirtyBitsToLength(DynArrayBytes32Pointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }
}