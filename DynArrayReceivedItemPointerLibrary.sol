pragma solidity ^0.8.17;

import "./ReceivedItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type DynArrayReceivedItemPointer is uint256;

using DynArrayReceivedItemPointerLibrary for DynArrayReceivedItemPointer global;

/// @dev Library for resolving pointers of a ReceivedItem[]
library DynArrayReceivedItemPointerLibrary {
  uint256 internal constant CalldataStride = 0xa0;

  function wrap(MemoryPointer ptr) internal pure returns (DynArrayReceivedItemPointer) {
    return DynArrayReceivedItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(DynArrayReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(DynArrayReceivedItemPointer.unwrap(ptr));
  }

  function head(DynArrayReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  function element(DynArrayReceivedItemPointer ptr, uint256 index) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset((index * CalldataStride) + 32);
  }

  function length(DynArrayReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function setLength(DynArrayReceivedItemPointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  function setMaxLength(DynArrayReceivedItemPointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  function addDirtyBitsToLength(DynArrayReceivedItemPointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }

  function elementData(DynArrayReceivedItemPointer ptr, uint256 index) internal pure returns (ReceivedItemPointer) {
    return ReceivedItemPointerLibrary.wrap(element(ptr, index));
  }
}