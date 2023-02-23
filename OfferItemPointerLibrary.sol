pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type OfferItemPointer is uint256;

using OfferItemPointerLibrary for OfferItemPointer global;

/// @dev Library for resolving pointers of a OfferItem
library OfferItemPointerLibrary {
  uint256 internal constant tokenOffset = 0x20;
  uint256 internal constant identifierOrCriteriaOffset = 0x40;
  uint256 internal constant startAmountOffset = 0x60;
  uint256 internal constant endAmountOffset = 0x80;

  function wrap(MemoryPointer ptr) internal pure returns (OfferItemPointer) {
    return OfferItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(OfferItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(OfferItemPointer.unwrap(ptr));
  }

  function itemType(OfferItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// Add dirty bits to `itemType`
  function addDirtyBitsToItemType(OfferItemPointer ptr) internal pure {
    itemType(ptr).addDirtyBitsBefore(0xfd);
  }

  function token(OfferItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(tokenOffset);
  }

  /// Add dirty bits to `token`
  function addDirtyBitsToToken(OfferItemPointer ptr) internal pure {
    token(ptr).addDirtyBitsBefore(0x60);
  }

  function identifierOrCriteria(OfferItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(identifierOrCriteriaOffset);
  }

  function startAmount(OfferItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(startAmountOffset);
  }

  function endAmount(OfferItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(endAmountOffset);
  }
}