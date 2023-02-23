pragma solidity ^0.8.17;

import "./DynArrayConsiderationItemPointerLibrary.sol";
import "./DynArrayOfferItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type OrderParametersPointer is uint256;

using OrderParametersPointerLibrary for OrderParametersPointer global;

/// @dev Library for resolving pointers of a OrderParameters
library OrderParametersPointerLibrary {
  uint256 internal constant zoneOffset = 0x20;
  uint256 internal constant offerOffset = 0x40;
  uint256 internal constant considerationOffset = 0x60;
  uint256 internal constant orderTypeOffset = 0x80;
  uint256 internal constant startTimeOffset = 0xa0;
  uint256 internal constant endTimeOffset = 0xc0;
  uint256 internal constant zoneHashOffset = 0xe0;
  uint256 internal constant saltOffset = 0x0100;
  uint256 internal constant conduitKeyOffset = 0x0120;
  uint256 internal constant totalOriginalConsiderationItemsOffset = 0x0140;
  uint256 internal constant HeadSize = 0x0160;

  function wrap(MemoryPointer ptr) internal pure returns (OrderParametersPointer) {
    return OrderParametersPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(OrderParametersPointer.unwrap(ptr));
  }

  function offerer(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// Add dirty bits to `offerer`
  function addDirtyBitsToOfferer(OrderParametersPointer ptr) internal pure {
    offerer(ptr).addDirtyBitsBefore(0x60);
  }

  function zone(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneOffset);
  }

  /// Add dirty bits to `zone`
  function addDirtyBitsToZone(OrderParametersPointer ptr) internal pure {
    zone(ptr).addDirtyBitsBefore(0x60);
  }

  function offerHead(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offerOffset);
  }

  function offerData(OrderParametersPointer ptr) internal pure returns (DynArrayOfferItemPointer) {
    return DynArrayOfferItemPointerLibrary.wrap(ptr.unwrap().offset(offerHead(ptr).readUint256()));
  }

  function addDirtyBitsToOfferOffset(OrderParametersPointer ptr) internal pure {
    offerHead(ptr).addDirtyBitsBefore(224);
  }

  function considerationHead(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(considerationOffset);
  }

  function considerationData(OrderParametersPointer ptr) internal pure returns (DynArrayConsiderationItemPointer) {
    return DynArrayConsiderationItemPointerLibrary.wrap(ptr.unwrap().offset(considerationHead(ptr).readUint256()));
  }

  function addDirtyBitsToConsiderationOffset(OrderParametersPointer ptr) internal pure {
    considerationHead(ptr).addDirtyBitsBefore(224);
  }

  function orderType(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(orderTypeOffset);
  }

  /// Add dirty bits to `orderType`
  function addDirtyBitsToOrderType(OrderParametersPointer ptr) internal pure {
    orderType(ptr).addDirtyBitsBefore(0xfd);
  }

  function startTime(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(startTimeOffset);
  }

  function endTime(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(endTimeOffset);
  }

  function zoneHash(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneHashOffset);
  }

  function salt(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(saltOffset);
  }

  function conduitKey(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(conduitKeyOffset);
  }

  function totalOriginalConsiderationItems(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(totalOriginalConsiderationItemsOffset);
  }

  function tail(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}