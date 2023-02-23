pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type SpentItemPointer is uint256;

using SpentItemPointerLibrary for SpentItemPointer global;

/// @dev Library for resolving pointers of a SpentItem
library SpentItemPointerLibrary {
  uint256 internal constant tokenOffset = 0x20;
  uint256 internal constant identifierOffset = 0x40;
  uint256 internal constant amountOffset = 0x60;

  function wrap(MemoryPointer ptr) internal pure returns (SpentItemPointer) {
    return SpentItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(SpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(SpentItemPointer.unwrap(ptr));
  }

  function itemType(SpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// Add dirty bits to `itemType`
  function addDirtyBitsToItemType(SpentItemPointer ptr) internal pure {
    itemType(ptr).addDirtyBitsBefore(0xfd);
  }

  function token(SpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(tokenOffset);
  }

  /// Add dirty bits to `token`
  function addDirtyBitsToToken(SpentItemPointer ptr) internal pure {
    token(ptr).addDirtyBitsBefore(0x60);
  }

  function identifier(SpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(identifierOffset);
  }

  function amount(SpentItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(amountOffset);
  }
}