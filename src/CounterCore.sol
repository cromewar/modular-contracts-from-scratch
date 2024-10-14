// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Core} from "@thirdweb-dev/src/Core.sol";
import {BeforeIncrementCallback} from "./interface/BeforeIncrementCallback.sol";

contract CounterCore is Core {
    // Contract variables
    uint256 count;

    // Constructor
    constructor(address owner) {
        _initializeOwner(owner);
    }

    // @dev - add this function to avoid warnings.
    receive() external payable {}

    // Function required by the Core contract import
    function getSupportedCallbackFunctions()
        public
        pure
        override
        returns (SupportedCallbackFunction[] memory supportedCallbackFunctions)
    {}

    // Contract function

    function increment() public {
        count += 1;
    }

    // Interface Functions

    function _beforeIncrement(
        uint256 _count
    ) internal returns (uint256 newCount) {
        (, bytes memory returnData) = _executeCallbackFunction(
            BeforeIncrementCallback.beforeIncrement.selector,
            abi.encodeCall(BeforeIncrementCallback.beforeIncrement, (_count))
        );

        newCount = abi.decode(returnData, (uint256));
    }
}
