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
    {
        supportedCallbackFunctions = new SupportedCallbackFunction[](1);
        supportedCallbackFunctions[0] = SupportedCallbackFunction({
            selector: BeforeIncrementCallback.beforeIncrement.selector,
            mode: CallbackMode.REQUIRED
        });
    }

    // Declaring the supported interfaces

    // for this particular interface the correct ID would actually be: 0xd40a8f2d
    function supportsInterface(
        bytes4 interfaceId
    ) public view override returns (bool) {
        interfaceId == 0x00000001 || super.supportsInterface(interfaceId);
    }

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
