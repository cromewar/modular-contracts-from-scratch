//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

library CounterStorage {
    /// @custom:storage-location erc7201:token.minting.counter
    bytes32 public constant COUNTER_STORAGE_POSITION =
        keccak256(abi.encode(uint256(keccak256("counter")) - 1)) &
            ~bytes32(uint256(0xff));

    struct Data {
        uint256 step;
    }

    function data() internal pure returns (Data storage data_) {
        bytes32 position = COUNTER_STORAGE_POSITION;
        assembly {
            data_.slot := position
        }
    }
}
