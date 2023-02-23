pragma solidity ^0.8.17;

import "./DynArrayConsiderationItemPointerLibrary.sol";
import "./DynArrayOfferItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type OrderComponentsPointer is uint256;

using OrderComponentsPointerLibrary for OrderComponentsPointer global;

/// @dev Library for resolving pointers of a OrderComponents
/// struct OrderComponents {
///   address offerer;
///   address zone;
///   OfferItem[] offer;
///   ConsiderationItem[] consideration;
///   OrderType orderType;
///   uint256 startTime;
///   uint256 endTime;
///   bytes32 zoneHash;
///   uint256 salt;
///   bytes32 conduitKey;
///   uint256 counter;
/// }
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

  /// @dev Convert a `MemoryPointer` to a `OrderComponentsPointer`.
  ///      This adds `OrderComponentsPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (OrderComponentsPointer) {
    return OrderComponentsPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `OrderComponentsPointer` back into a `MemoryPointer`.
  function unwrap(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(OrderComponentsPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of `offerer` in memory.
  ///      This points to the beginning of the encoded `address`
  function offerer(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Add dirty bits to `offerer`
  function addDirtyBitsToOfferer(OrderComponentsPointer ptr) internal pure {
    offerer(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `zone` in memory.
  ///      This points to the beginning of the encoded `address`
  function zone(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneOffset);
  }

  /// @dev Add dirty bits to `zone`
  function addDirtyBitsToZone(OrderComponentsPointer ptr) internal pure {
    zone(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `offer` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function offerHead(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offerOffset);
  }

  /// @dev Resolve the `DynArrayOfferItemPointer` pointing to the data buffer of `offer`
  function offerData(OrderComponentsPointer ptr) internal pure returns (DynArrayOfferItemPointer) {
    return DynArrayOfferItemPointerLibrary.wrap(ptr.unwrap().offset(offerHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `offer` (offset relative to parent).
  function addDirtyBitsToOfferOffset(OrderComponentsPointer ptr) internal pure {
    offerHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the head of `consideration` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function considerationHead(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(considerationOffset);
  }

  /// @dev Resolve the `DynArrayConsiderationItemPointer` pointing to the data buffer of `consideration`
  function considerationData(OrderComponentsPointer ptr) internal pure returns (DynArrayConsiderationItemPointer) {
    return DynArrayConsiderationItemPointerLibrary.wrap(ptr.unwrap().offset(considerationHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `consideration` (offset relative to parent).
  function addDirtyBitsToConsiderationOffset(OrderComponentsPointer ptr) internal pure {
    considerationHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the head of `orderType` in memory.
  ///      This points to the beginning of the encoded `OrderType`
  function orderType(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(orderTypeOffset);
  }

  /// @dev Add dirty bits to `orderType`
  function addDirtyBitsToOrderType(OrderComponentsPointer ptr) internal pure {
    orderType(ptr).addDirtyBitsBefore(0xfd);
  }

  /// @dev Resolve the pointer to the head of `startTime` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function startTime(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(startTimeOffset);
  }

  /// @dev Resolve the pointer to the head of `endTime` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function endTime(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(endTimeOffset);
  }

  /// @dev Resolve the pointer to the head of `zoneHash` in memory.
  ///      This points to the beginning of the encoded `bytes32`
  function zoneHash(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneHashOffset);
  }

  /// @dev Resolve the pointer to the head of `salt` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function salt(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(saltOffset);
  }

  /// @dev Resolve the pointer to the head of `conduitKey` in memory.
  ///      This points to the beginning of the encoded `bytes32`
  function conduitKey(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(conduitKeyOffset);
  }

  /// @dev Resolve the pointer to the head of `counter` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function counter(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(counterOffset);
  }

  /// @dev Resolve the pointer to the tail segment of the struct.
  ///      This is the beginning of the dynamically encoded data.
  function tail(OrderComponentsPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}