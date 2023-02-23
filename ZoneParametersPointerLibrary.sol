pragma solidity ^0.8.17;

import "./DynArrayBytes32PointerLibrary.sol";
import "./BytesPointerLibrary.sol";
import "./DynArrayReceivedItemPointerLibrary.sol";
import "./DynArraySpentItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type ZoneParametersPointer is uint256;

using ZoneParametersPointerLibrary for ZoneParametersPointer global;

/// @dev Library for resolving pointers of a ZoneParameters
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

  function wrap(MemoryPointer ptr) internal pure returns (ZoneParametersPointer) {
    return ZoneParametersPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(ZoneParametersPointer.unwrap(ptr));
  }

  function orderHash(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function fulfiller(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(fulfillerOffset);
  }

  /// Add dirty bits to `fulfiller`
  function addDirtyBitsToFulfiller(ZoneParametersPointer ptr) internal pure {
    fulfiller(ptr).addDirtyBitsBefore(0x60);
  }

  function offerer(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offererOffset);
  }

  /// Add dirty bits to `offerer`
  function addDirtyBitsToOfferer(ZoneParametersPointer ptr) internal pure {
    offerer(ptr).addDirtyBitsBefore(0x60);
  }

  function offerHead(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offerOffset);
  }

  function offerData(ZoneParametersPointer ptr) internal pure returns (DynArraySpentItemPointer) {
    return DynArraySpentItemPointerLibrary.wrap(ptr.unwrap().offset(offerHead(ptr).readUint256()));
  }

  function addDirtyBitsToOfferOffset(ZoneParametersPointer ptr) internal pure {
    offerHead(ptr).addDirtyBitsBefore(224);
  }

  function considerationHead(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(considerationOffset);
  }

  function considerationData(ZoneParametersPointer ptr) internal pure returns (DynArrayReceivedItemPointer) {
    return DynArrayReceivedItemPointerLibrary.wrap(ptr.unwrap().offset(considerationHead(ptr).readUint256()));
  }

  function addDirtyBitsToConsiderationOffset(ZoneParametersPointer ptr) internal pure {
    considerationHead(ptr).addDirtyBitsBefore(224);
  }

  function extraDataHead(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(extraDataOffset);
  }

  function extraDataData(ZoneParametersPointer ptr) internal pure returns (BytesPointer) {
    return BytesPointerLibrary.wrap(ptr.unwrap().offset(extraDataHead(ptr).readUint256()));
  }

  function addDirtyBitsToExtraDataOffset(ZoneParametersPointer ptr) internal pure {
    extraDataHead(ptr).addDirtyBitsBefore(224);
  }

  function orderHashesHead(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(orderHashesOffset);
  }

  function orderHashesData(ZoneParametersPointer ptr) internal pure returns (DynArrayBytes32Pointer) {
    return DynArrayBytes32PointerLibrary.wrap(ptr.unwrap().offset(orderHashesHead(ptr).readUint256()));
  }

  function addDirtyBitsToOrderHashesOffset(ZoneParametersPointer ptr) internal pure {
    orderHashesHead(ptr).addDirtyBitsBefore(224);
  }

  function startTime(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(startTimeOffset);
  }

  function endTime(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(endTimeOffset);
  }

  function zoneHash(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneHashOffset);
  }

  function tail(ZoneParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}