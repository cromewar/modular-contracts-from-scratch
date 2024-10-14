//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

interface BeforeIncrementCallback {
    function beforeIncrement(uint256 count) external returns (uint256);
}
