pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type SpentItemPointer is uint256;

using SpentItemPointerLibrary for SpentItemPointer global;

/// @dev Library for resolving pointers of a SpentItem
/// struct SpentItem {
///   ItemType itemType;
///   address token;
///   uint256 identifier;
///   uint256 amount;
/// }
library SpentItemPointerLibrary {
  uint256 internal constant tokenOffset = 0x20;
  uint256 internal constant identifierOffset = 0x40;
  uint256 internal constant amountOffset = 0x60;

  /// @dev Convert a `MemoryPointer` to a `SpentItemPointer`.
  ///      This adds `SpentItemPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (SpentItemPointer) {
    return SpentItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `SpentItemPointer` back into a `MemoryPointer`.
  function unwrap(SpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(SpentItemPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of `itemType` in memory.
  ///      This points to the beginning of the encoded `ItemType`
  function itemType(SpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Add dirty bits to `itemType`
  function addDirtyBitsToItemType(SpentItemPointer ptr) internal pure {
    itemType(ptr).addDirtyBitsBefore(0xfd);
  }

  /// @dev Resolve the pointer to the head of `token` in memory.
  ///      This points to the beginning of the encoded `address`
  function token(SpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(tokenOffset);
  }

  /// @dev Add dirty bits to `token`
  function addDirtyBitsToToken(SpentItemPointer ptr) internal pure {
    token(ptr).addDirtyBitsBefore(0x60);
  }

  /// @dev Resolve the pointer to the head of `identifier` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function identifier(SpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(identifierOffset);
  }

  /// @dev Resolve the pointer to the head of `amount` in memory.
  ///      This points to the beginning of the encoded `uint256`
  function amount(SpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(amountOffset);
  }
}