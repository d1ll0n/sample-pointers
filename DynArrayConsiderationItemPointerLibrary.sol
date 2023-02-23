pragma solidity ^0.8.17;

import "./ConsiderationItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type DynArrayConsiderationItemPointer is uint256;

using DynArrayConsiderationItemPointerLibrary for DynArrayConsiderationItemPointer global;

/// @dev Library for resolving pointers of a ConsiderationItem[]
library DynArrayConsiderationItemPointerLibrary {
  uint256 internal constant CalldataStride = 0xc0;

  function wrap(MemoryPointer ptr) internal pure returns (DynArrayConsiderationItemPointer) {
    return DynArrayConsiderationItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(DynArrayConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(DynArrayConsiderationItemPointer.unwrap(ptr));
  }

  function head(DynArrayConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  function element(DynArrayConsiderationItemPointer ptr, uint256 index) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset((index * CalldataStride) + 32);
  }

  function length(DynArrayConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function setLength(DynArrayConsiderationItemPointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  function setMaxLength(DynArrayConsiderationItemPointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  function addDirtyBitsToLength(DynArrayConsiderationItemPointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }

  function elementData(DynArrayConsiderationItemPointer ptr, uint256 index) internal pure returns (ConsiderationItemPointer) {
    return ConsiderationItemPointerLibrary.wrap(element(ptr, index));
  }
}