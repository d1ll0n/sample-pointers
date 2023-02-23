pragma solidity ^0.8.17;

import "./BytesPointerLibrary.sol";
import "./OrderParametersPointerLibrary.sol";
import "./PointerLibraries.sol";

type AdvancedOrderPointer is uint256;

using AdvancedOrderPointerLibrary for AdvancedOrderPointer global;

/// @dev Library for resolving pointers of a AdvancedOrder
/// struct AdvancedOrder {
///   OrderParameters parameters;
///   uint120 numerator;
///   uint120 denominator;
///   bytes signature;
///   bytes extraData;
/// }
library AdvancedOrderPointerLibrary {
  uint256 internal constant numeratorOffset = 0x20;
  uint256 internal constant OverflowedNumerator = 0x01000000000000000000000000000000;
  uint256 internal constant denominatorOffset = 0x40;
  uint256 internal constant OverflowedDenominator = 0x01000000000000000000000000000000;
  uint256 internal constant signatureOffset = 0x60;
  uint256 internal constant extraDataOffset = 0x80;
  uint256 internal constant HeadSize = 0xa0;

  /// @dev Convert a `MemoryPointer` to a `AdvancedOrderPointer`.
  ///      This adds `AdvancedOrderPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (AdvancedOrderPointer) {
    return AdvancedOrderPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `AdvancedOrderPointer` back into a `MemoryPointer`.
  function unwrap(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(AdvancedOrderPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of `parameters` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function parametersHead(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Resolve the `OrderParametersPointer` pointing to the data buffer of `parameters`
  function parametersData(AdvancedOrderPointer ptr) internal pure returns (OrderParametersPointer) {
    return OrderParametersPointerLibrary.wrap(ptr.unwrap().offset(parametersHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `parameters` (offset relative to parent).
  function addDirtyBitsToParametersOffset(AdvancedOrderPointer ptr) internal pure {
    parametersHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the head of `numerator` in memory.
  ///      This points to the beginning of the encoded `uint120`
  function numerator(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(numeratorOffset);
  }

  /// @dev Add dirty bits to `numerator`
  function addDirtyBitsToNumerator(AdvancedOrderPointer ptr) internal pure {
    numerator(ptr).addDirtyBitsBefore(0x88);
  }

  /// @dev Cause `numerator` to overflow
  function overflowNumerator(AdvancedOrderPointer ptr) internal pure {
    numerator(ptr).write(OverflowedNumerator);
  }

  /// @dev Resolve the pointer to the head of `denominator` in memory.
  ///      This points to the beginning of the encoded `uint120`
  function denominator(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(denominatorOffset);
  }

  /// @dev Add dirty bits to `denominator`
  function addDirtyBitsToDenominator(AdvancedOrderPointer ptr) internal pure {
    denominator(ptr).addDirtyBitsBefore(0x88);
  }

  /// @dev Cause `denominator` to overflow
  function overflowDenominator(AdvancedOrderPointer ptr) internal pure {
    denominator(ptr).write(OverflowedDenominator);
  }

  /// @dev Resolve the pointer to the head of `signature` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function signatureHead(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(signatureOffset);
  }

  /// @dev Resolve the `BytesPointer` pointing to the data buffer of `signature`
  function signatureData(AdvancedOrderPointer ptr) internal pure returns (BytesPointer) {
    return BytesPointerLibrary.wrap(ptr.unwrap().offset(signatureHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `signature` (offset relative to parent).
  function addDirtyBitsToSignatureOffset(AdvancedOrderPointer ptr) internal pure {
    signatureHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the head of `extraData` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function extraDataHead(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(extraDataOffset);
  }

  /// @dev Resolve the `BytesPointer` pointing to the data buffer of `extraData`
  function extraDataData(AdvancedOrderPointer ptr) internal pure returns (BytesPointer) {
    return BytesPointerLibrary.wrap(ptr.unwrap().offset(extraDataHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `extraData` (offset relative to parent).
  function addDirtyBitsToExtraDataOffset(AdvancedOrderPointer ptr) internal pure {
    extraDataHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the tail segment of the struct.
  ///      This is the beginning of the dynamically encoded data.
  function tail(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}