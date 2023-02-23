pragma solidity ^0.8.17;

import "./BytesPointerLibrary.sol";
import "./DynArrayAdditionalRecipientPointerLibrary.sol";
import "./PointerLibraries.sol";

type BasicOrderParametersPointer is uint256;

using BasicOrderParametersPointerLibrary for BasicOrderParametersPointer global;

/// @dev Library for resolving pointers of a BasicOrderParameters
library BasicOrderParametersPointerLibrary {
  uint256 internal constant considerationIdentifierOffset = 0x20;
  uint256 internal constant considerationAmountOffset = 0x40;
  uint256 internal constant offererOffset = 0x60;
  uint256 internal constant zoneOffset = 0x80;
  uint256 internal constant offerTokenOffset = 0xa0;
  uint256 internal constant offerIdentifierOffset = 0xc0;
  uint256 internal constant offerAmountOffset = 0xe0;
  uint256 internal constant basicOrderTypeOffset = 0x0100;
  uint256 internal constant startTimeOffset = 0x0120;
  uint256 internal constant endTimeOffset = 0x0140;
  uint256 internal constant zoneHashOffset = 0x0160;
  uint256 internal constant saltOffset = 0x0180;
  uint256 internal constant offererConduitKeyOffset = 0x01a0;
  uint256 internal constant fulfillerConduitKeyOffset = 0x01c0;
  uint256 internal constant totalOriginalAdditionalRecipientsOffset = 0x01e0;
  uint256 internal constant additionalRecipientsOffset = 0x0200;
  uint256 internal constant signatureOffset = 0x0220;
  uint256 internal constant HeadSize = 0x0240;

  function wrap(MemoryPointer ptr) internal pure returns (BasicOrderParametersPointer) {
    return BasicOrderParametersPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(BasicOrderParametersPointer.unwrap(ptr));
  }

  function considerationToken(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// Add dirty bits to `considerationToken`
  function addDirtyBitsToConsiderationToken(BasicOrderParametersPointer ptr) internal pure {
    considerationToken(ptr).addDirtyBitsBefore(0x60);
  }

  function considerationIdentifier(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(considerationIdentifierOffset);
  }

  function considerationAmount(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(considerationAmountOffset);
  }

  function offerer(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offererOffset);
  }

  /// Add dirty bits to `offerer`
  function addDirtyBitsToOfferer(BasicOrderParametersPointer ptr) internal pure {
    offerer(ptr).addDirtyBitsBefore(0x60);
  }

  function zone(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneOffset);
  }

  /// Add dirty bits to `zone`
  function addDirtyBitsToZone(BasicOrderParametersPointer ptr) internal pure {
    zone(ptr).addDirtyBitsBefore(0x60);
  }

  function offerToken(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offerTokenOffset);
  }

  /// Add dirty bits to `offerToken`
  function addDirtyBitsToOfferToken(BasicOrderParametersPointer ptr) internal pure {
    offerToken(ptr).addDirtyBitsBefore(0x60);
  }

  function offerIdentifier(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offerIdentifierOffset);
  }

  function offerAmount(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offerAmountOffset);
  }

  function basicOrderType(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(basicOrderTypeOffset);
  }

  /// Add dirty bits to `basicOrderType`
  function addDirtyBitsToBasicOrderType(BasicOrderParametersPointer ptr) internal pure {
    basicOrderType(ptr).addDirtyBitsBefore(0xfb);
  }

  function startTime(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(startTimeOffset);
  }

  function endTime(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(endTimeOffset);
  }

  function zoneHash(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneHashOffset);
  }

  function salt(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(saltOffset);
  }

  function offererConduitKey(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offererConduitKeyOffset);
  }

  function fulfillerConduitKey(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(fulfillerConduitKeyOffset);
  }

  function totalOriginalAdditionalRecipients(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(totalOriginalAdditionalRecipientsOffset);
  }

  function additionalRecipientsHead(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(additionalRecipientsOffset);
  }

  function additionalRecipientsData(BasicOrderParametersPointer ptr) internal pure returns (DynArrayAdditionalRecipientPointer) {
    return DynArrayAdditionalRecipientPointerLibrary.wrap(ptr.unwrap().offset(additionalRecipientsHead(ptr).readUint256()));
  }

  function addDirtyBitsToAdditionalRecipientsOffset(BasicOrderParametersPointer ptr) internal pure {
    additionalRecipientsHead(ptr).addDirtyBitsBefore(224);
  }

  function signatureHead(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(signatureOffset);
  }

  function signatureData(BasicOrderParametersPointer ptr) internal pure returns (BytesPointer) {
    return BytesPointerLibrary.wrap(ptr.unwrap().offset(signatureHead(ptr).readUint256()));
  }

  function addDirtyBitsToSignatureOffset(BasicOrderParametersPointer ptr) internal pure {
    signatureHead(ptr).addDirtyBitsBefore(224);
  }

  function tail(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}