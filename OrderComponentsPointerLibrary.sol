pragma solidity ^0.8.17;

import "./DynArrayConsiderationItemPointerLibrary.sol";
import "./DynArrayOfferItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type OrderComponentsPointer is uint256;

using OrderComponentsPointerLibrary for OrderComponentsPointer global;

/// @dev Library for resolving pointers of a OrderComponents
library OrderComponentsPointerLibrary {
  uint256 internal constant zoneOffset = 0x20;
  uint256 internal constant offerOffset = 0x40;
  uint256 internal constant considerationOffset = 0x60;
  uint256 internal constant orderTypeOffset = 0x80;
  uint256 internal constant startTimeOffset = 0xa0;
  uint256 internal constant endTimeOffset = 0xc0;
  uint256 internal constant zoneHashOffset = 0xe0;
  uint256 internal constant saltOffset = 0x0100;
  uint256 internal constant conduitKeyOffset = 0x0120;
  uint256 internal constant counterOffset = 0x0140;
  uint256 internal constant HeadSize = 0x0160;

  function wrap(MemoryPointer ptr) internal pure returns (OrderComponentsPointer) {
    return OrderComponentsPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(OrderComponentsPointer.unwrap(ptr));
  }

  function offerer(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// Add dirty bits to `offerer`
  function addDirtyBitsToOfferer(OrderComponentsPointer ptr) internal pure {
    offerer(ptr).addDirtyBitsBefore(0x60);
  }

  function zone(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneOffset);
  }

  /// Add dirty bits to `zone`
  function addDirtyBitsToZone(OrderComponentsPointer ptr) internal pure {
    zone(ptr).addDirtyBitsBefore(0x60);
  }

  function offerHead(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offerOffset);
  }

  function offerData(OrderComponentsPointer ptr) internal pure returns (DynArrayOfferItemPointer) {
    return DynArrayOfferItemPointerLibrary.wrap(ptr.unwrap().offset(offerHead(ptr).readUint256()));
  }

  function addDirtyBitsToOfferOffset(OrderComponentsPointer ptr) internal pure {
    offerHead(ptr).addDirtyBitsBefore(224);
  }

  function considerationHead(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(considerationOffset);
  }

  function considerationData(OrderComponentsPointer ptr) internal pure returns (DynArrayConsiderationItemPointer) {
    return DynArrayConsiderationItemPointerLibrary.wrap(ptr.unwrap().offset(considerationHead(ptr).readUint256()));
  }

  function addDirtyBitsToConsiderationOffset(OrderComponentsPointer ptr) internal pure {
    considerationHead(ptr).addDirtyBitsBefore(224);
  }

  function orderType(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(orderTypeOffset);
  }

  /// Add dirty bits to `orderType`
  function addDirtyBitsToOrderType(OrderComponentsPointer ptr) internal pure {
    orderType(ptr).addDirtyBitsBefore(0xfd);
  }

  function startTime(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(startTimeOffset);
  }

  function endTime(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(endTimeOffset);
  }

  function zoneHash(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneHashOffset);
  }

  function salt(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(saltOffset);
  }

  function conduitKey(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(conduitKeyOffset);
  }

  function counter(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(counterOffset);
  }

  function tail(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}