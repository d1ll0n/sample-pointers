pragma solidity ^0.8.17;

import "./SpentItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type DynArraySpentItemPointer is uint256;

using DynArraySpentItemPointerLibrary for DynArraySpentItemPointer global;

/// @dev Library for resolving pointers of a SpentItem[]
library DynArraySpentItemPointerLibrary {
  uint256 internal constant CalldataStride = 0x80;

  function wrap(MemoryPointer ptr) internal pure returns (DynArraySpentItemPointer) {
    return DynArraySpentItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(DynArraySpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(DynArraySpentItemPointer.unwrap(ptr));
  }

  function head(DynArraySpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  function element(DynArraySpentItemPointer ptr, uint256 index) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset((index * CalldataStride) + 32);
  }

  function length(DynArraySpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function setLength(DynArraySpentItemPointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  function setMaxLength(DynArraySpentItemPointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  function addDirtyBitsToLength(DynArraySpentItemPointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }

  function elementData(DynArraySpentItemPointer ptr, uint256 index) internal pure returns (SpentItemPointer) {
    return SpentItemPointerLibrary.wrap(element(ptr, index));
  }
}