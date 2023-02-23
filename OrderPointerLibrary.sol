pragma solidity ^0.8.17;

import "./BytesPointerLibrary.sol";
import "./OrderParametersPointerLibrary.sol";
import "./PointerLibraries.sol";

type OrderPointer is uint256;

using OrderPointerLibrary for OrderPointer global;

/// @dev Library for resolving pointers of a Order
library OrderPointerLibrary {
  uint256 internal constant signatureOffset = 0x20;
  uint256 internal constant HeadSize = 0x40;

  function wrap(MemoryPointer ptr) internal pure returns (OrderPointer) {
    return OrderPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(OrderPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(OrderPointer.unwrap(ptr));
  }

  function parametersHead(OrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function parametersData(OrderPointer ptr) internal pure returns (OrderParametersPointer) {
    return OrderParametersPointerLibrary.wrap(ptr.unwrap().offset(parametersHead(ptr).readUint256()));
  }

  function addDirtyBitsToParametersOffset(OrderPointer ptr) internal pure {
    parametersHead(ptr).addDirtyBitsBefore(224);
  }

  function signatureHead(OrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(signatureOffset);
  }

  function signatureData(OrderPointer ptr) internal pure returns (BytesPointer) {
    return BytesPointerLibrary.wrap(ptr.unwrap().offset(signatureHead(ptr).readUint256()));
  }

  function addDirtyBitsToSignatureOffset(OrderPointer ptr) internal pure {
    signatureHead(ptr).addDirtyBitsBefore(224);
  }

  function tail(OrderPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}