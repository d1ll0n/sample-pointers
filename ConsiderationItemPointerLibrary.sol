pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type ConsiderationItemPointer is uint256;

using ConsiderationItemPointerLibrary for ConsiderationItemPointer global;

/// @dev Library for resolving pointers of a ConsiderationItem
/// struct ConsiderationItem {
///   ItemType itemType;
///   address token;
///   uint256 identifierOrCriteria;
///   uint256 startAmount;
///   uint256 endAmount;
///   address recipient;
/// }
library ConsiderationItemPointerLibrary {
  uint256 internal constant tokenOffset = 0x20;
  uint256 internal constant identifierOrCriteriaOffset = 0x40;
  uint256 internal constant startAmountOffset = 0x60;
  uint256 internal constant endAmountOffset = 0x80;
  uint256 internal constant recipientOffset = 0xa0;

  /// @dev Convert a `MemoryPointer` to a `ConsiderationItemPointer`.
  ///      This adds `ConsiderationItemPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (ConsiderationItemPointer) {
    return ConsiderationItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `ConsiderationItemPointer` back into a `MemoryPointer`.
  function unwrap(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(ConsiderationItemPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of `itemType` in memory.
  ///      This points to the beginning of the encoded `ItemType`
  function itemType(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Add dirty bits to `itemType`
  function addDirtyBitsToItemType(ConsiderationItemPointer ptr) internal pure {
    itemType(ptr).addDirtyBitsBefore(0xfd);
  }

  /// @dev Resolve the pointer to the head of `token` in memory.
  ///      This points to the beginning of the encoded `address`
  function token(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(tokenOffset);
  }

  /// @dev Add dirty bits to `token`
  function addDirtyBitsToToken(ConsiderationItemPointer ptr) internal pure {
    token(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `identifierOrCriteria` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function identifierOrCriteria(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(identifierOrCriteriaOffset);
  }

  /// @dev Resolve the pointer to the head of `startAmount` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function startAmount(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(startAmountOffset);
  }

  /// @dev Resolve the pointer to the head of `endAmount` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function endAmount(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(endAmountOffset);
  }

  /// @dev Resolve the pointer to the head of `recipient` in memory.
  ///      This points to the beginning of the encoded `address`
  function recipient(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(recipientOffset);
  }

  /// @dev Add dirty bits to `recipient`
  function addDirtyBitsToRecipient(ConsiderationItemPointer ptr) internal pure {
    recipient(ptr).addDirtyBitsBefore(0x60);
  }
}