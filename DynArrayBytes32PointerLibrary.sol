pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type DynArrayBytes32Pointer is uint256;

using DynArrayBytes32PointerLibrary for DynArrayBytes32Pointer global;

/// @dev Library for resolving pointers of a bytes32[]
library DynArrayBytes32PointerLibrary {
  uint256 internal constant CalldataStride = 0x20;

  function wrap(MemoryPointer ptr) internal pure returns (DynArrayBytes32Pointer) {
    return DynArrayBytes32Pointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(DynArrayBytes32Pointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(DynArrayBytes32Pointer.unwrap(ptr));
  }

  function head(DynArrayBytes32Pointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  function element(DynArrayBytes32Pointer ptr, uint256 index) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset((index * CalldataStride) + 32);
  }

  function length(DynArrayBytes32Pointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function setLength(DynArrayBytes32Pointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  function setMaxLength(DynArrayBytes32Pointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  function addDirtyBitsToLength(DynArrayBytes32Pointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }
}