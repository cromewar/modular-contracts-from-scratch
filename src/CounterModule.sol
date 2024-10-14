//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Module} from "@thirdweb-dev/src/Module.sol";
import {CounterStorage} from "./library/CounterStorage.sol";

contract CounterModule is Module {
    // Functions required by the Module import
    function getModuleConfig()
        public
        pure
        override
        returns (ModuleConfig memory config)
    {}

    // Contract Function

    // Counter Storage uses the the library and the Data struct.
    function _counterStorage()
        internal
        pure
        returns (CounterStorage.Data storage)
    {
        return CounterStorage.data();
    }

    // Callback and Fallback Functions

    // Fallback Functions
    function getStep() external view returns (uint256) {
        return _counterStorage().step;
    }

    function setStep(uint256 _step) external {
        _counterStorage().step = _step;
    }

    // Callback Functions
    function beforeIncrement(uint256 count) external view returns (uint256) {
        return count + _counterStorage().step;
    }
}
