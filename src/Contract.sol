// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { SSTORE2 } from "solmate/utils/SSTORE2.sol";
import { InflateLib } from "src/InflateLib.sol";

contract Contract {

    address public pointer;
    uint256 uncompressedDataLength;

    function read() external view returns (bytes memory) {
        return SSTORE2.read(pointer);
    }

    function write(bytes calldata data) external {
        pointer = SSTORE2.write(data);
    }

    function writeCompressed(bytes calldata compressedData, uint256 uncompressedDataLength_) external {
        pointer = SSTORE2.write(compressedData);
        uncompressedDataLength = uncompressedDataLength_;
    }

    function readCompressed() external view returns (bytes memory decompressed) {
        bytes memory data = SSTORE2.read(pointer);
        (, decompressed) = InflateLib.puff(data, uncompressedDataLength);
    }
}
