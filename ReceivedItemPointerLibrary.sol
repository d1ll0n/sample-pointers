pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type ReceivedItemPointer is uint256;

using ReceivedItemPointerLibrary for ReceivedItemPointer global;

/// @dev Library for resolving pointers of a ReceivedItem
/// struct ReceivedItem {
///   ItemType itemType;
///   address token;
///   uint256 identifier;
///   uint256 amount;
///   address recipient;
/// }
library ReceivedItemPointerLibrary {
  uint256 internal constant tokenOffset = 0x20;
  uint256 internal constant identifierOffset = 0x40;
  uint256 internal constant amountOffset = 0x60;
  uint256 internal constant recipientOffset = 0x80;

  /// @dev Convert a `MemoryPointer` to a `ReceivedItemPointer`.
  ///      This adds `ReceivedItemPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (ReceivedItemPointer) {
    return ReceivedItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `ReceivedItemPointer` back into a `MemoryPointer`.
  function unwrap(ReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(ReceivedItemPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of `itemType` in memory.
  ///      This points to the beginning of the encoded `ItemType`
  function itemType(ReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Add dirty bits to `itemType`
  function addDirtyBitsToItemType(ReceivedItemPointer ptr) internal pure {
    itemType(ptr).addDirtyBitsBefore(0xfd);
  }

  /// @dev Resolve the pointer to the head of `token` in memory.
  ///      This points to the beginning of the encoded `address`
  function token(ReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(tokenOffset);
  }

  /// @dev Add dirty bits to `token`
  function addDirtyBitsToToken(ReceivedItemPointer ptr) internal pure {
    token(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `identifier` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function identifier(ReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(identifierOffset);
  }

  /// @dev Resolve the pointer to the head of `amount` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function amount(ReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(amountOffset);
  }

  /// @dev Resolve the pointer to the head of `recipient` in memory.
  ///      This points to the beginning of the encoded `address`
  function recipient(ReceivedItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(recipientOffset);
  }

  /// @dev Add dirty bits to `recipient`
  function addDirtyBitsToRecipient(ReceivedItemPointer ptr) internal pure {
    recipient(ptr).addDirtyBitsBefore(0x60);
  }
}