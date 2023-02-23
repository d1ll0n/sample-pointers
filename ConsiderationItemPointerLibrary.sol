pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type ConsiderationItemPointer is uint256;

using ConsiderationItemPointerLibrary for ConsiderationItemPointer global;

/// @dev Library for resolving pointers of a ConsiderationItem
library ConsiderationItemPointerLibrary {
  uint256 internal constant tokenOffset = 0x20;
  uint256 internal constant identifierOrCriteriaOffset = 0x40;
  uint256 internal constant startAmountOffset = 0x60;
  uint256 internal constant endAmountOffset = 0x80;
  uint256 internal constant recipientOffset = 0xa0;

  function wrap(MemoryPointer ptr) internal pure returns (ConsiderationItemPointer) {
    return ConsiderationItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(ConsiderationItemPointer.unwrap(ptr));
  }

  function itemType(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// Add dirty bits to `itemType`
  function addDirtyBitsToItemType(ConsiderationItemPointer ptr) internal pure {
    itemType(ptr).addDirtyBitsBefore(0xfd);
  }

  function token(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(tokenOffset);
  }

  /// Add dirty bits to `token`
  function addDirtyBitsToToken(ConsiderationItemPointer ptr) internal pure {
    token(ptr).addDirtyBitsBefore(0x60);
  }

  function identifierOrCriteria(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(identifierOrCriteriaOffset);
  }

  function startAmount(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(startAmountOffset);
  }

  function endAmount(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(endAmountOffset);
  }

  function recipient(ConsiderationItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(recipientOffset);
  }

  /// Add dirty bits to `recipient`
  function addDirtyBitsToRecipient(ConsiderationItemPointer ptr) internal pure {
    recipient(ptr).addDirtyBitsBefore(0x60);
  }
}