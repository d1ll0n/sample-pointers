pragma solidity ^0.8.17;

import "./DynArrayBytes32PointerLibrary.sol";
import "./PointerLibraries.sol";

type CriteriaResolverPointer is uint256;

using CriteriaResolverPointerLibrary for CriteriaResolverPointer global;

/// @dev Library for resolving pointers of a CriteriaResolver
library CriteriaResolverPointerLibrary {
  uint256 internal constant sideOffset = 0x20;
  uint256 internal constant indexOffset = 0x40;
  uint256 internal constant identifierOffset = 0x60;
  uint256 internal constant criteriaProofOffset = 0x80;
  uint256 internal constant HeadSize = 0xa0;

  function wrap(MemoryPointer ptr) internal pure returns (CriteriaResolverPointer) {
    return CriteriaResolverPointer.wrap(MemoryPointer.unwrap(ptr));
  }

  function unwrap(CriteriaResolverPointer ptr) internal pure returns (MemoryPointer) {
    return MemoryPointer.wrap(CriteriaResolverPointer.unwrap(ptr));
  }

  function orderIndex(CriteriaResolverPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap();
  }

  function side(CriteriaResolverPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(sideOffset);
  }

  /// Add dirty bits to `side`
  function addDirtyBitsToSide(CriteriaResolverPointer ptr) internal pure {
    side(ptr).addDirtyBitsBefore(0xff);
  }

  function index(CriteriaResolverPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(indexOffset);
  }

  function identifier(CriteriaResolverPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(identifierOffset);
  }

  function criteriaProofHead(CriteriaResolverPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(criteriaProofOffset);
  }

  function criteriaProofData(CriteriaResolverPointer ptr) internal pure returns (DynArrayBytes32Pointer) {
    return DynArrayBytes32PointerLibrary.wrap(ptr.unwrap().offset(criteriaProofHead(ptr).readUint256()));
  }

  function addDirtyBitsToCriteriaProofOffset(CriteriaResolverPointer ptr) internal pure {
    criteriaProofHead(ptr).addDirtyBitsBefore(224);
  }

  function tail(CriteriaResolverPointer ptr) internal pure returns (MemoryPointer) {
    return ptr.unwrap().offset(HeadSize);
  }
}