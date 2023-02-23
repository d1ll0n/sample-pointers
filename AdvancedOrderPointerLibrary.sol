pragma solidity ^0.8.17;

import "./BytesPointerLibrary.sol";
import "./OrderParametersPointerLibrary.sol";
import "./PointerLibraries.sol";

type AdvancedOrderPointer is uint256;

using AdvancedOrderPointerLibrary for AdvancedOrderPointer global;

/// @dev Library for resolving pointers of a AdvancedOrder
library AdvancedOrderPointerLibrary {
  uint256 internal constant numeratorOffset = 0x20;
  uint256 internal constant OverflowedNumerator = 0x01000000000000000000000000000000;
  uint256 internal constant denominatorOffset = 0x40;
  uint256 internal constant OverflowedDenominator = 0x01000000000000000000000000000000;
  uint256 internal constant signatureOffset = 0x60;
  uint256 internal constant extraDataOffset = 0x80;
  uint256 internal constant HeadSize = 0xa0;

  function wrap(MemoryPointer ptr) internal pure returns (AdvancedOrderPointer) {
    return AdvancedOrderPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(AdvancedOrderPointer.unwrap(ptr));
  }

  function parametersHead(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function parametersData(AdvancedOrderPointer ptr) internal pure returns (OrderParametersPointer) {
    return OrderParametersPointerLibrary.wrap(ptr.unwrap().offset(parametersHead(ptr).readUint256()));
  }

  function addDirtyBitsToParametersOffset(AdvancedOrderPointer ptr) internal pure {
    parametersHead(ptr).addDirtyBitsBefore(224);
  }

  function numerator(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(numeratorOffset);
  }

  /// Add dirty bits to `numerator`
  function addDirtyBitsToNumerator(AdvancedOrderPointer ptr) internal pure {
    numerator(ptr).addDirtyBitsBefore(0x88);
  }

  /// Cause `numerator` to overflow
  function overflowNumerator(AdvancedOrderPointer ptr) internal pure {
    numerator(ptr).write(OverflowedNumerator);
  }

  function denominator(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(denominatorOffset);
  }

  /// Add dirty bits to `denominator`
  function addDirtyBitsToDenominator(AdvancedOrderPointer ptr) internal pure {
    denominator(ptr).addDirtyBitsBefore(0x88);
  }

  /// Cause `denominator` to overflow
  function overflowDenominator(AdvancedOrderPointer ptr) internal pure {
    denominator(ptr).write(OverflowedDenominator);
  }

  function signatureHead(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(signatureOffset);
  }

  function signatureData(AdvancedOrderPointer ptr) internal pure returns (BytesPointer) {
    return BytesPointerLibrary.wrap(ptr.unwrap().offset(signatureHead(ptr).readUint256()));
  }

  function addDirtyBitsToSignatureOffset(AdvancedOrderPointer ptr) internal pure {
    signatureHead(ptr).addDirtyBitsBefore(224);
  }

  function extraDataHead(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(extraDataOffset);
  }

  function extraDataData(AdvancedOrderPointer ptr) internal pure returns (BytesPointer) {
    return BytesPointerLibrary.wrap(ptr.unwrap().offset(extraDataHead(ptr).readUint256()));
  }

  function addDirtyBitsToExtraDataOffset(AdvancedOrderPointer ptr) internal pure {
    extraDataHead(ptr).addDirtyBitsBefore(224);
  }

  function tail(AdvancedOrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}