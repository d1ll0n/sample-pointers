pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type ReceivedItemPointer is uint256;

using ReceivedItemPointerLibrary for ReceivedItemPointer global;

/// @dev Library for resolving pointers of a ReceivedItem
library ReceivedItemPointerLibrary {
  uint256 internal constant tokenOffset = 0x20;
  uint256 internal constant identifierOffset = 0x40;
  uint256 internal constant amountOffset = 0x60;
  uint256 internal constant recipientOffset = 0x80;

  function wrap(MemoryPointer ptr) internal pure returns (ReceivedItemPointer) {
    return ReceivedItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(ReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(ReceivedItemPointer.unwrap(ptr));
  }

  function itemType(ReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// Add dirty bits to `itemType`
  function addDirtyBitsToItemType(ReceivedItemPointer ptr) internal pure {
    itemType(ptr).addDirtyBitsBefore(0xfd);
  }

  function token(ReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(tokenOffset);
  }

  /// Add dirty bits to `token`
  function addDirtyBitsToToken(ReceivedItemPointer ptr) internal pure {
    token(ptr).addDirtyBitsBefore(0x60);
  }

  function identifier(ReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(identifierOffset);
  }

  function amount(ReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(amountOffset);
  }

  function recipient(ReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(recipientOffset);
  }

  /// Add dirty bits to `recipient`
  function addDirtyBitsToRecipient(ReceivedItemPointer ptr) internal pure {
    recipient(ptr).addDirtyBitsBefore(0x60);
  }
}