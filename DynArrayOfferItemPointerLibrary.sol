pragma solidity ^0.8.17;

import "./OfferItemPointerLibrary.sol";
import "./PointerLibraries.sol";

type DynArrayOfferItemPointer is uint256;

using DynArrayOfferItemPointerLibrary for DynArrayOfferItemPointer global;

/// @dev Library for resolving pointers of a OfferItem[]
library DynArrayOfferItemPointerLibrary {
  uint256 internal constant CalldataStride = 0xa0;

  function wrap(MemoryPointer ptr) internal pure returns (DynArrayOfferItemPointer) {
    return DynArrayOfferItemPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(DynArrayOfferItemPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(DynArrayOfferItemPointer.unwrap(ptr));
  }

  function head(DynArrayOfferItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  function element(DynArrayOfferItemPointer ptr, uint256 index) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset((index * CalldataStride) + 32);
  }

  function length(DynArrayOfferItemPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function setLength(DynArrayOfferItemPointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  function setMaxLength(DynArrayOfferItemPointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  function addDirtyBitsToLength(DynArrayOfferItemPointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }

  function elementData(DynArrayOfferItemPointer ptr, uint256 index) internal pure returns (OfferItemPointer) {
    return OfferItemPointerLibrary.wrap(element(ptr, index));
  }
}