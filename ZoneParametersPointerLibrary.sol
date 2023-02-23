pragma solidity ^0.8.17;

import "./DynArrayBytes32PointerLibrary.sol";
import "./BytesPointerLibrary.sol";
import "./DynArrayReceivedItemPointerLibrary.sol";
import "./DynArraySpentItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type ZoneParametersPointer is uint256;

using ZoneParametersPointerLibrary for ZoneParametersPointer global;

/// @dev Library for resolving pointers of a ZoneParameters
/// struct ZoneParameters {
///   bytes32 orderHash;
///   address fulfiller;
///   address offerer;
///   SpentItem[] offer;
///   ReceivedItem[] consideration;
///   bytes extraData;
///   bytes32[] orderHashes;
///   uint256 startTime;
///   uint256 endTime;
///   bytes32 zoneHash;
/// }
library ZoneParametersPointerLibrary {
  uint256 internal constant fulfillerOffset = 0x20;
  uint256 internal constant offererOffset = 0x40;
  uint256 internal constant offerOffset = 0x60;
  uint256 internal constant considerationOffset = 0x80;
  uint256 internal constant extraDataOffset = 0xa0;
  uint256 internal constant orderHashesOffset = 0xc0;
  uint256 internal constant startTimeOffset = 0xe0;
  uint256 internal constant endTimeOffset = 0x0100;
  uint256 internal constant zoneHashOffset = 0x0120;
  uint256 internal constant HeadSize = 0x0140;

  /// @dev Convert a `MemoryPointer` to a `ZoneParametersPointer`.
  ///      This adds `ZoneParametersPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (ZoneParametersPointer) {
    return ZoneParametersPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `ZoneParametersPointer` back into a `MemoryPointer`.
  function unwrap(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(ZoneParametersPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of `orderHash` in memory.
  ///      This points to the beginning of the encoded `bytes32`
  function orderHash(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Resolve the pointer to the head of `fulfiller` in memory.
  ///      This points to the beginning of the encoded `address`
  function fulfiller(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(fulfillerOffset);
  }

  /// @dev Add dirty bits to `fulfiller`
  function addDirtyBitsToFulfiller(ZoneParametersPointer ptr) internal pure {
    fulfiller(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `offerer` in memory.
  ///      This points to the beginning of the encoded `address`
  function offerer(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offererOffset);
  }

  /// @dev Add dirty bits to `offerer`
  function addDirtyBitsToOfferer(ZoneParametersPointer ptr) internal pure {
    offerer(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `offer` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function offerHead(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offerOffset);
  }

  /// @dev Resolve the `DynArraySpentItemPointer` pointing to the data buffer of `offer`
  function offerData(ZoneParametersPointer ptr) internal pure returns (DynArraySpentItemPointer) {
    return DynArraySpentItemPointerLibrary.wrap(ptr.unwrap().offset(offerHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `offer` (offset relative to parent).
  function addDirtyBitsToOfferOffset(ZoneParametersPointer ptr) internal pure {
    offerHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the head of `consideration` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function considerationHead(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(considerationOffset);
  }

  /// @dev Resolve the `DynArrayReceivedItemPointer` pointing to the data buffer of `consideration`
  function considerationData(ZoneParametersPointer ptr) internal pure returns (DynArrayReceivedItemPointer) {
    return DynArrayReceivedItemPointerLibrary.wrap(ptr.unwrap().offset(considerationHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `consideration` (offset relative to parent).
  function addDirtyBitsToConsiderationOffset(ZoneParametersPointer ptr) internal pure {
    considerationHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the head of `extraData` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function extraDataHead(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(extraDataOffset);
  }

  /// @dev Resolve the `BytesPointer` pointing to the data buffer of `extraData`
  function extraDataData(ZoneParametersPointer ptr) internal pure returns (BytesPointer) {
    return BytesPointerLibrary.wrap(ptr.unwrap().offset(extraDataHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `extraData` (offset relative to parent).
  function addDirtyBitsToExtraDataOffset(ZoneParametersPointer ptr) internal pure {
    extraDataHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the head of `orderHashes` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function orderHashesHead(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(orderHashesOffset);
  }

  /// @dev Resolve the `DynArrayBytes32Pointer` pointing to the data buffer of `orderHashes`
  function orderHashesData(ZoneParametersPointer ptr) internal pure returns (DynArrayBytes32Pointer) {
    return DynArrayBytes32PointerLibrary.wrap(ptr.unwrap().offset(orderHashesHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `orderHashes` (offset relative to parent).
  function addDirtyBitsToOrderHashesOffset(ZoneParametersPointer ptr) internal pure {
    orderHashesHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the head of `startTime` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function startTime(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(startTimeOffset);
  }

  /// @dev Resolve the pointer to the head of `endTime` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function endTime(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(endTimeOffset);
  }

  /// @dev Resolve the pointer to the head of `zoneHash` in memory.
  ///      This points to the beginning of the encoded `bytes32`
  function zoneHash(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneHashOffset);
  }

  /// @dev Resolve the pointer to the tail segment of the struct.
  ///      This is the beginning of the dynamically encoded data.
  function tail(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}