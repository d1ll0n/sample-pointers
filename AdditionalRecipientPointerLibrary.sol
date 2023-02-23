pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type AdditionalRecipientPointer is uint256;

using AdditionalRecipientPointerLibrary for AdditionalRecipientPointer global;

/// @dev Library for resolving pointers of a AdditionalRecipient
library AdditionalRecipientPointerLibrary {
  uint256 internal constant recipientOffset = 0x20;

  function wrap(MemoryPointer ptr) internal pure returns (AdditionalRecipientPointer) {
    return AdditionalRecipientPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(AdditionalRecipientPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(AdditionalRecipientPointer.unwrap(ptr));
  }

  function amount(AdditionalRecipientPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function recipient(AdditionalRecipientPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(recipientOffset);
  }

  /// Add dirty bits to `recipient`
  function addDirtyBitsToRecipient(AdditionalRecipientPointer ptr) internal pure {
    recipient(ptr).addDirtyBitsBefore(0x60);
  }
}