pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type BytesPointer is uint256;

using BytesPointerLibrary for BytesPointer global;

/// @dev Library for resolving pointers of a bytes
library BytesPointerLibrary {
  function wrap(MemoryPointer ptr) internal pure returns (BytesPointer) {
    return BytesPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(BytesPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(BytesPointer.unwrap(ptr));
  }

  function length(BytesPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function setLength(BytesPointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  function setMaxLength(BytesPointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  function addDirtyBitsToLength(BytesPointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }

  function data(BytesPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  function addDirtyBitsToEnd(BytesPointer ptr) internal pure {
    uint256 _length = length(ptr).readUint256();
    uint256 remainder = _length % 32;
    MemoryPointer lastWord = ptr.unwrap().next().offset(_length - remainder);
    lastWord.addDirtyBitsAfter(8 * remainder);
  }
}