pragma solidity ^0.8.17;

import "./AdditionalRecipientPointerLibrary.sol";
import "./PointerLibraries.sol";

type DynArrayAdditionalRecipientPointer is uint256;

using DynArrayAdditionalRecipientPointerLibrary for DynArrayAdditionalRecipientPointer global;

/// @dev Library for resolving pointers of a AdditionalRecipient[]
library DynArrayAdditionalRecipientPointerLibrary {
  uint256 internal constant CalldataStride = 0x40;

  /// @dev Convert a `MemoryPointer` to a `DynArrayAdditionalRecipientPointer`.
  ///      This adds `DynArrayAdditionalRecipientPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (DynArrayAdditionalRecipientPointer) {
    return DynArrayAdditionalRecipientPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `DynArrayAdditionalRecipientPointer` back into a `MemoryPointer`.
  function unwrap(DynArrayAdditionalRecipientPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(DynArrayAdditionalRecipientPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of the array.
  ///      This points to the first item's data
  function head(DynArrayAdditionalRecipientPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  /// @dev Resolve the pointer to the head of `arr[index]` in memory.
  ///      This points to the beginning of the encoded `AdditionalRecipient[]`
  function element(DynArrayAdditionalRecipientPointer ptr, uint256 index) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset((index * CalldataStride) + 32);
  }

  /// @dev Resolve the pointer for the length of the `AdditionalRecipient[]` at `ptr`.
  function length(DynArrayAdditionalRecipientPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Set the length for the `AdditionalRecipient[]` at `ptr` to `length`.
  function setLength(DynArrayAdditionalRecipientPointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  /// @dev Set the length for the `AdditionalRecipient[]` at `ptr` to `type(uint256).max`.
  function setMaxLength(DynArrayAdditionalRecipientPointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  /// @dev Add dirty bits from 0 to 224 to the length for the `AdditionalRecipient[]` at `ptr`
  function addDirtyBitsToLength(DynArrayAdditionalRecipientPointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the `AdditionalRecipientPointer` pointing to the data buffer of `arr[index]`
  function elementData(DynArrayAdditionalRecipientPointer ptr, uint256 index) internal pure returns (AdditionalRecipientPointer) {
    return AdditionalRecipientPointerLibrary.wrap(element(ptr, index));
  }
}