pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type OrderStatusPointer is uint256;

using OrderStatusPointerLibrary for OrderStatusPointer global;

/// @dev Library for resolving pointers of a OrderStatus
library OrderStatusPointerLibrary {
  uint256 internal constant isCancelledOffset = 0x20;
  uint256 internal constant numeratorOffset = 0x40;
  uint256 internal constant OverflowedNumerator = 0x01000000000000000000000000000000;
  uint256 internal constant denominatorOffset = 0x60;
  uint256 internal constant OverflowedDenominator = 0x01000000000000000000000000000000;

  function wrap(MemoryPointer ptr) internal pure returns (OrderStatusPointer) {
    return OrderStatusPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(OrderStatusPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(OrderStatusPointer.unwrap(ptr));
  }

  function isValidated(OrderStatusPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// Add dirty bits to `isValidated`
  function addDirtyBitsToIsValidated(OrderStatusPointer ptr) internal pure {
    isValidated(ptr).addDirtyBitsBefore(0xff);
  }

  function isCancelled(OrderStatusPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(isCancelledOffset);
  }

  /// Add dirty bits to `isCancelled`
  function addDirtyBitsToIsCancelled(OrderStatusPointer ptr) internal pure {
    isCancelled(ptr).addDirtyBitsBefore(0xff);
  }

  function numerator(OrderStatusPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(numeratorOffset);
  }

  /// Add dirty bits to `numerator`
  function addDirtyBitsToNumerator(OrderStatusPointer ptr) internal pure {
    numerator(ptr).addDirtyBitsBefore(0x88);
  }

  /// Cause `numerator` to overflow
  function overflowNumerator(OrderStatusPointer ptr) internal pure {
    numerator(ptr).write(OverflowedNumerator);
  }

  function denominator(OrderStatusPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(denominatorOffset);
  }

  /// Add dirty bits to `denominator`
  function addDirtyBitsToDenominator(OrderStatusPointer ptr) internal pure {
    denominator(ptr).addDirtyBitsBefore(0x88);
  }

  /// Cause `denominator` to overflow
  function overflowDenominator(OrderStatusPointer ptr) internal pure {
    denominator(ptr).write(OverflowedDenominator);
  }
}