// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Core} from "@thirdweb-dev/src/Core.sol";

interface BeforeIncrementCallback {
    function beforeIncrement(uint256 count) external returns (uint256);
}

contract CounterCore is Core {
    receive() external payable {}

    function getSupportedCallbackFunctions()
        public
        pure
        override
        returns (SupportedCallbackFunction[] memory supportedCallbackFunctions)
    {}
}
