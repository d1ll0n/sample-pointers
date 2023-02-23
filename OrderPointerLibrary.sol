pragma solidity ^0.8.17;

import "./BytesPointerLibrary.sol";
import "./OrderParametersPointerLibrary.sol";
import "./PointerLibraries.sol";

type OrderPointer is uint256;

using OrderPointerLibrary for OrderPointer global;

/// @dev Library for resolving pointers of a Order
/// struct Order {
///   OrderParameters parameters;
///   bytes signature;
/// }
library OrderPointerLibrary {
  uint256 internal constant signatureOffset = 0x20;
  uint256 internal constant HeadSize = 0x40;

  /// @dev Convert a `MemoryPointer` to a `OrderPointer`.
  ///      This adds `OrderPointerLibrary` functions as members of the pointer
  function wrap(MemoryPointer ptr) internal pure returns (OrderPointer) {
    return OrderPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  /// @dev Convert a `OrderPointer` back into a `MemoryPointer`.
  function unwrap(OrderPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(OrderPointer.unwrap(ptr));
  }

  /// @dev Resolve the pointer to the head of `parameters` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function parametersHead(OrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  /// @dev Resolve the `OrderParametersPointer` pointing to the data buffer of `parameters`
  function parametersData(OrderPointer ptr) internal pure returns (OrderParametersPointer) {
    return OrderParametersPointerLibrary.wrap(ptr.unwrap().offset(parametersHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `parameters` (offset relative to parent).
  function addDirtyBitsToParametersOffset(OrderPointer ptr) internal pure {
    parametersHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the head of `signature` in memory.
  ///      This points to the offset of the item's data relative to `ptr`
  function signatureHead(OrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(signatureOffset);
  }

  /// @dev Resolve the `BytesPointer` pointing to the data buffer of `signature`
  function signatureData(OrderPointer ptr) internal pure returns (BytesPointer) {
    return BytesPointerLibrary.wrap(ptr.unwrap().offset(signatureHead(ptr).readUint256()));
  }

  /// @dev Add dirty bits to the head for `signature` (offset relative to parent).
  function addDirtyBitsToSignatureOffset(OrderPointer ptr) internal pure {
    signatureHead(ptr).addDirtyBitsBefore(224);
  }

  /// @dev Resolve the pointer to the tail segment of the struct.
  ///      This is the beginning of the dynamically encoded data.
  function tail(OrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}