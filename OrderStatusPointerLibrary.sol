pragma solidity ^0.8.17;

import "./PointerLibraries.sol";

type OrderStatusPointer is uint256;

using OrderStatusPointerLibrary for OrderStatusPointer global;

/// @dev Library for resolving pointers of a OrderStatus
/// struct OrderStatus {
///   bool isValidated;
///   bool isCancelled;
///   uint120 numerator;
///   uint120 denominator;
/// }
library OrderStatusPointerLibrary {
  uint256 internal constant isCancelledOffset = 0x20;
  uint256 internal constant numeratorOffset = 0x40;
  uint256 internal constant OverflowedNumerator = 0x01000000000000000000000000000000;
  uint256 internal constant denominatorOffset = 0x60;
  uint256 internal constant OverflowedDenominator = 0x01000000000000000000000000000000;

  /// @dev Convert a `MemoryPointer` to a `OrderStatusPointer`.
  ///      This adds `OrderStatusPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (OrderStatusPointer) {
    return OrderStatusPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `OrderStatusPointer` back into a `MemoryPointer`.
  function unwrap(OrderStatusPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(OrderStatusPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of `isValidated` in memory.
  ///      This points to the beginning of the encoded `bool`
  function isValidated(OrderStatusPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Add dirty bits to `isValidated`
  function addDirtyBitsToIsValidated(OrderStatusPointer ptr) internal pure {
    isValidated(ptr).addDirtyBitsBefore(0xff);
  }

  /// @dev Resolve the pointer to the head of `isCancelled` in memory.
  ///      This points to the beginning of the encoded `bool`
  function isCancelled(OrderStatusPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(isCancelledOffset);
  }

  /// @dev Add dirty bits to `isCancelled`
  function addDirtyBitsToIsCancelled(OrderStatusPointer ptr) internal pure {
    isCancelled(ptr).addDirtyBitsBefore(0xff);
  }

  /// @dev Resolve the pointer to the head of `numerator` in memory.
  ///      This points to the beginning of the encoded `uint120`
  function numerator(OrderStatusPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(numeratorOffset);
  }

  /// @dev Add dirty bits to `numerator`
  function addDirtyBitsToNumerator(OrderStatusPointer ptr) internal pure {
    numerator(ptr).addDirtyBitsBefore(0x88);
  }

  /// @dev Cause `numerator` to overflow
  function overflowNumerator(OrderStatusPointer ptr) internal pure {
    numerator(ptr).write(OverflowedNumerator);
  }

  /// @dev Resolve the pointer to the head of `denominator` in memory.
  ///      This points to the beginning of the encoded `uint120`
  function denominator(OrderStatusPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(denominatorOffset);
  }

  /// @dev Add dirty bits to `denominator`
  function addDirtyBitsToDenominator(OrderStatusPointer ptr) internal pure {
    denominator(ptr).addDirtyBitsBefore(0x88);
  }

  /// @dev Cause `denominator` to overflow
  function overflowDenominator(OrderStatusPointer ptr) internal pure {
    denominator(ptr).write(OverflowedDenominator);
  }
}