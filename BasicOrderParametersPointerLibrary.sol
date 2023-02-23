pragma solidity ^0.8.17;

import "./BytesPointerLibrary.sol";
import "./DynArrayAdditionalRecipientPointerLibrary.sol";
import "./PointerLibraries.sol";

type BasicOrderParametersPointer is uint256;

using BasicOrderParametersPointerLibrary for BasicOrderParametersPointer global;

/// @dev Library for resolving pointers of a BasicOrderParameters
/// struct BasicOrderParameters {
///   address considerationToken;
///   uint256 considerationIdentifier;
///   uint256 considerationAmount;
///   address offerer;
///   address zone;
///   address offerToken;
///   uint256 offerIdentifier;
///   uint256 offerAmount;
///   BasicOrderType basicOrderType;
///   uint256 startTime;
///   uint256 endTime;
///   bytes32 zoneHash;
///   uint256 salt;
///   bytes32 offererConduitKey;
///   bytes32 fulfillerConduitKey;
///   uint256 totalOriginalAdditionalRecipients;
///   AdditionalRecipient[] additionalRecipients;
///   bytes signature;
/// }
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

  /// @dev Convert a `MemoryPointer` to a `BasicOrderParametersPointer`.
  ///      This adds `BasicOrderParametersPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (BasicOrderParametersPointer) {
    return BasicOrderParametersPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `BasicOrderParametersPointer` back into a `MemoryPointer`.
  function unwrap(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(BasicOrderParametersPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of `considerationToken` in memory.
  ///      This points to the beginning of the encoded `address`
  function considerationToken(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Add dirty bits to `considerationToken`
  function addDirtyBitsToConsiderationToken(BasicOrderParametersPointer ptr) internal pure {
    considerationToken(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `considerationIdentifier` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function considerationIdentifier(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(considerationIdentifierOffset);
  }

  /// @dev Resolve the pointer to the head of `considerationAmount` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function considerationAmount(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(considerationAmountOffset);
  }

  /// @dev Resolve the pointer to the head of `offerer` in memory.
  ///      This points to the beginning of the encoded `address`
  function offerer(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offererOffset);
  }

  /// @dev Add dirty bits to `offerer`
  function addDirtyBitsToOfferer(BasicOrderParametersPointer ptr) internal pure {
    offerer(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `zone` in memory.
  ///      This points to the beginning of the encoded `address`
  function zone(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneOffset);
  }

  /// @dev Add dirty bits to `zone`
  function addDirtyBitsToZone(BasicOrderParametersPointer ptr) internal pure {
    zone(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `offerToken` in memory.
  ///      This points to the beginning of the encoded `address`
  function offerToken(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offerTokenOffset);
  }

  /// @dev Add dirty bits to `offerToken`
  function addDirtyBitsToOfferToken(BasicOrderParametersPointer ptr) internal pure {
    offerToken(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `offerIdentifier` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function offerIdentifier(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offerIdentifierOffset);
  }

  /// @dev Resolve the pointer to the head of `offerAmount` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function offerAmount(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offerAmountOffset);
  }

  /// @dev Resolve the pointer to the head of `basicOrderType` in memory.
  ///      This points to the beginning of the encoded `BasicOrderType`
  function basicOrderType(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(basicOrderTypeOffset);
  }

  /// @dev Add dirty bits to `basicOrderType`
  function addDirtyBitsToBasicOrderType(BasicOrderParametersPointer ptr) internal pure {
    basicOrderType(ptr).addDirtyBitsBefore(0xfb);
  }

  /// @dev Resolve the pointer to the head of `startTime` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function startTime(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(startTimeOffset);
  }

  /// @dev Resolve the pointer to the head of `endTime` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function endTime(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(endTimeOffset);
  }

  /// @dev Resolve the pointer to the head of `zoneHash` in memory.
  ///      This points to the beginning of the encoded `bytes32`
  function zoneHash(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(zoneHashOffset);
  }

  /// @dev Resolve the pointer to the head of `salt` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function salt(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(saltOffset);
  }

  /// @dev Resolve the pointer to the head of `offererConduitKey` in memory.
  ///      This points to the beginning of the encoded `bytes32`
  function offererConduitKey(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(offererConduitKeyOffset);
  }

  /// @dev Resolve the pointer to the head of `fulfillerConduitKey` in memory.
  ///      This points to the beginning of the encoded `bytes32`
  function fulfillerConduitKey(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(fulfillerConduitKeyOffset);
  }

  /// @dev Resolve the pointer to the head of `totalOriginalAdditionalRecipients` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function totalOriginalAdditionalRecipients(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(totalOriginalAdditionalRecipientsOffset);
  }

  /// @dev Resolve the pointer to the head of `additionalRecipients` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function additionalRecipientsHead(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(additionalRecipientsOffset);
  }

  /// @dev Resolve the `DynArrayAdditionalRecipientPointer` pointing to the data buffer of `additionalRecipients`
  function additionalRecipientsData(BasicOrderParametersPointer ptr) internal pure returns (DynArrayAdditionalRecipientPointer) {
    return DynArrayAdditionalRecipientPointerLibrary.wrap(ptr.unwrap().offset(additionalRecipientsHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `additionalRecipients` (offset relative to parent).
  function addDirtyBitsToAdditionalRecipientsOffset(BasicOrderParametersPointer ptr) internal pure {
    additionalRecipientsHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the head of `signature` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function signatureHead(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(signatureOffset);
  }

  /// @dev Resolve the `BytesPointer` pointing to the data buffer of `signature`
  function signatureData(BasicOrderParametersPointer ptr) internal pure returns (BytesPointer) {
    return BytesPointerLibrary.wrap(ptr.unwrap().offset(signatureHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `signature` (offset relative to parent).
  function addDirtyBitsToSignatureOffset(BasicOrderParametersPointer ptr) internal pure {
    signatureHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the tail segment of the struct.
  ///      This is the beginning of the dynamically encoded data.
  function tail(BasicOrderParametersPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}