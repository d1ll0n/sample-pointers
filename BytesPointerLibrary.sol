pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type BytesPointer is uint256;

using BytesPointerLibrary for BytesPointer global;

/// @dev Library for resolving pointers of a bytes
library BytesPointerLibrary {
  /// @dev Convert a `MemoryPointer` to a `BytesPointer`.
  ///      This adds `BytesPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (BytesPointer) {
    return BytesPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `BytesPointer` back into a `MemoryPointer`.
  function unwrap(BytesPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(BytesPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer for the length of the `bytes` at `ptr`.
  function length(BytesPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Set the length for the `bytes` at `ptr` to `length`.
  function setLength(BytesPointer ptr, uint256 _length) internal pure {
    length(ptr).write(_length);
  }

  /// @dev Set the length for the `bytes` at `ptr` to `type(uint256).max`.
  function setMaxLength(BytesPointer ptr) internal pure {
    setLength(ptr, type(uint256).max);
  }

  /// @dev Add dirty bits from 0 to 224 to the length for the `bytes` at `ptr`
  function addDirtyBitsToLength(BytesPointer ptr) internal pure {
    length(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the beginning of the bytes data.
  function data(BytesPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(_OneWord);
  }

  /// @dev Add dirty bits to the end of the buffer if its length is not divisible by 32
  function addDirtyBitsToEnd(BytesPointer ptr) internal pure {
    uint256 _length = length(ptr).readUint256();
    uint256 remainder = _length % 32;
    if (remainder > 0) {
      MemoryPointer lastWord = ptr.unwrap().next().offset(_length - remainder);
      lastWord.addDirtyBitsAfter(8 * remainder);
    }
  }
}