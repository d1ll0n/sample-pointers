pragma solidity ^0.8.17;

import "./DynArrayFulfillmentComponentPointerLibrary.sol";
import "./PointerLibraries.sol";

type FulfillmentPointer is uint256;

using FulfillmentPointerLibrary for FulfillmentPointer global;

/// @dev Library for resolving pointers of a Fulfillment
library FulfillmentPointerLibrary {
  uint256 internal constant considerationComponentsOffset = 0x20;
  uint256 internal constant HeadSize = 0x40;

  function wrap(MemoryPointer ptr) internal pure returns (FulfillmentPointer) {
    return FulfillmentPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(FulfillmentPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(FulfillmentPointer.unwrap(ptr));
  }

  function offerComponentsHead(FulfillmentPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function offerComponentsData(FulfillmentPointer ptr) internal pure returns (DynArrayFulfillmentComponentPointer) {
    return DynArrayFulfillmentComponentPointerLibrary.wrap(ptr.unwrap().offset(offerComponentsHead(ptr).readUint256()));
  }

  function addDirtyBitsToOfferComponentsOffset(FulfillmentPointer ptr) internal pure {
    offerComponentsHead(ptr).addDirtyBitsBefore(224);
  }

  function considerationComponentsHead(FulfillmentPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(considerationComponentsOffset);
  }

  function considerationComponentsData(FulfillmentPointer ptr) internal pure returns (DynArrayFulfillmentComponentPointer) {
    return DynArrayFulfillmentComponentPointerLibrary.wrap(ptr.unwrap().offset(considerationComponentsHead(ptr).readUint256()));
  }

  function addDirtyBitsToConsiderationComponentsOffset(FulfillmentPointer ptr) internal pure {
    considerationComponentsHead(ptr).addDirtyBitsBefore(224);
  }

  function tail(FulfillmentPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}