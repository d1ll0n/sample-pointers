pragma solidity ^0.8.17;

import "./DynArrayConsiderationItemPointerLibrary.sol";
import "./DynArrayOfferItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type OrderParametersPointer is uint256;

using OrderParametersPointerLibrary for OrderParametersPointer global;

/// @dev Library for resolving pointers of a OrderParameters
/// struct OrderParameters {
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
///   uint256 totalOriginalConsiderationItems;
/// }
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

  /// @dev Convert a `MemoryPointer` to a `OrderParametersPointer`.
  ///      This adds `OrderParametersPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (OrderParametersPointer) {
    return OrderParametersPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `OrderParametersPointer` back into a `MemoryPointer`.
  function unwrap(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(OrderParametersPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of `offerer` in memory.
  ///      This points to the beginning of the encoded `address`
  function offerer(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Add dirty bits to `offerer`
  function addDirtyBitsToOfferer(OrderParametersPointer ptr) internal pure {
    offerer(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `zone` in memory.
  ///      This points to the beginning of the encoded `address`
  function zone(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneOffset);
  }

  /// @dev Add dirty bits to `zone`
  function addDirtyBitsToZone(OrderParametersPointer ptr) internal pure {
    zone(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `offer` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function offerHead(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offerOffset);
  }

  /// @dev Resolve the `DynArrayOfferItemPointer` pointing to the data buffer of `offer`
  function offerData(OrderParametersPointer ptr) internal pure returns (DynArrayOfferItemPointer) {
    return DynArrayOfferItemPointerLibrary.wrap(ptr.unwrap().offset(offerHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `offer` (offset relative to parent).
  function addDirtyBitsToOfferOffset(OrderParametersPointer ptr) internal pure {
    offerHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the head of `consideration` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function considerationHead(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(considerationOffset);
  }

  /// @dev Resolve the `DynArrayConsiderationItemPointer` pointing to the data buffer of `consideration`
  function considerationData(OrderParametersPointer ptr) internal pure returns (DynArrayConsiderationItemPointer) {
    return DynArrayConsiderationItemPointerLibrary.wrap(ptr.unwrap().offset(considerationHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `consideration` (offset relative to parent).
  function addDirtyBitsToConsiderationOffset(OrderParametersPointer ptr) internal pure {
    considerationHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the head of `orderType` in memory.
  ///      This points to the beginning of the encoded `OrderType`
  function orderType(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(orderTypeOffset);
  }

  /// @dev Add dirty bits to `orderType`
  function addDirtyBitsToOrderType(OrderParametersPointer ptr) internal pure {
    orderType(ptr).addDirtyBitsBefore(0xfd);
  }

  /// @dev Resolve the pointer to the head of `startTime` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function startTime(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(startTimeOffset);
  }

  /// @dev Resolve the pointer to the head of `endTime` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function endTime(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(endTimeOffset);
  }

  /// @dev Resolve the pointer to the head of `zoneHash` in memory.
  ///      This points to the beginning of the encoded `bytes32`
  function zoneHash(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneHashOffset);
  }

  /// @dev Resolve the pointer to the head of `salt` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function salt(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(saltOffset);
  }

  /// @dev Resolve the pointer to the head of `conduitKey` in memory.
  ///      This points to the beginning of the encoded `bytes32`
  function conduitKey(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(conduitKeyOffset);
  }

  /// @dev Resolve the pointer to the head of `totalOriginalConsiderationItems` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function totalOriginalConsiderationItems(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(totalOriginalConsiderationItemsOffset);
  }

  /// @dev Resolve the pointer to the tail segment of the struct.
  ///      This is the beginning of the dynamically encoded data.
  function tail(OrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}