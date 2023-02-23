pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type FulfillmentComponentPointer is uint256;

using FulfillmentComponentPointerLibrary for FulfillmentComponentPointer global;

/// @dev Library for resolving pointers of a FulfillmentComponent
library FulfillmentComponentPointerLibrary {
  uint256 internal constant itemIndexOffset = 0x20;

  function wrap(MemoryPointer ptr) internal pure returns (FulfillmentComponentPointer) {
    return FulfillmentComponentPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(FulfillmentComponentPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(FulfillmentComponentPointer.unwrap(ptr));
  }

  function orderIndex(FulfillmentComponentPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function itemIndex(FulfillmentComponentPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(itemIndexOffset);
  }
}