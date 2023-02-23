pragma solidity ^0.8.17;

import "./AdditionalRecipientPointerLibrary.sol";
import "./PointerLibraries.sol";

type DynArrayAdditionalRecipientPointer is uint256;

using DynArrayAdditionalRecipientPointerLibrary for DynArrayAdditionalRecipientPointer global;

/// @dev Library for resolving pointers of a AdditionalRecipient[]
library DynArrayAdditionalRecipientPointerLibrary {
  uint256 internal constant CalldataStride = 0x40;

  function wrap(MemoryPointer ptr) internal pure returns (DynArrayAdditionalRecipientPointer) {
    return DynArrayAdditionalRecipientPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(DynArrayAdditionalRecipientPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(DynArrayAdditionalRecipientPointer.unwrap(ptr));
  }

  function head(DynArrayAdditionalRecipientPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  function element(DynArrayAdditionalRecipientPointer ptr, uint256 index) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset((index * CalldataStride) + 32);
  }

  function length(DynArrayAdditionalRecipientPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function setLength(DynArrayAdditionalRecipientPointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  function setMaxLength(DynArrayAdditionalRecipientPointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  function addDirtyBitsToLength(DynArrayAdditionalRecipientPointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }

  function elementData(DynArrayAdditionalRecipientPointer ptr, uint256 index) internal pure returns (AdditionalRecipientPointer) {
    return AdditionalRecipientPointerLibrary.wrap(element(ptr, index));
  }
}