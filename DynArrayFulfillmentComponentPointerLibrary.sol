pragma solidity ^0.8.17;

import "./FulfillmentComponentPointerLibrary.sol";
import "./PointerLibraries.sol";

type DynArrayFulfillmentComponentPointer is uint256;

using DynArrayFulfillmentComponentPointerLibrary for DynArrayFulfillmentComponentPointer global;

/// @dev Library for resolving pointers of a FulfillmentComponent[]
library DynArrayFulfillmentComponentPointerLibrary {
  uint256 internal constant CalldataStride = 0x40;

  function wrap(MemoryPointer ptr) internal pure returns (DynArrayFulfillmentComponentPointer) {
    return DynArrayFulfillmentComponentPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(DynArrayFulfillmentComponentPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(DynArrayFulfillmentComponentPointer.unwrap(ptr));
  }

  function head(DynArrayFulfillmentComponentPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  function element(DynArrayFulfillmentComponentPointer ptr, uint256 index) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset((index * CalldataStride) + 32);
  }

  function length(DynArrayFulfillmentComponentPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function setLength(DynArrayFulfillmentComponentPointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  function setMaxLength(DynArrayFulfillmentComponentPointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  function addDirtyBitsToLength(DynArrayFulfillmentComponentPointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }

  function elementData(DynArrayFulfillmentComponentPointer ptr, uint256 index) internal pure returns (FulfillmentComponentPointer) {
    return FulfillmentComponentPointerLibrary.wrap(element(ptr, index));
  }
}