//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Module} from "@thirdweb-dev/src/Module.sol";
import {Role} from "@thirdweb-dev/src/Role.sol";
import {CounterStorage} from "./library/CounterStorage.sol";

contract CounterModule is Module {
    // Functions required by the Module import
    function getModuleConfig()
        public
        pure
        override
        returns (ModuleConfig memory config)
    {
        // Callback Function array of one element
        config.callbackFunctions = new CallbackFunction[](1);
        // Fallback Function array of two elements
        config.fallbackFunctions = new FallbackFunction[](2);

        //adding the functions to the arrays
        config.callbackFunctions[0] = CallbackFunction(
            this.beforeIncrement.selector
        );

        config.fallbackFunctions[0] = FallbackFunction({
            selector: this.getStep.selector,
            permissionBits: 0
        });

        config.fallbackFunctions[1] = FallbackFunction({
            selector: this.setStep.selector,
            permissionBits: Role._MANAGER_ROLE
        });

        // Required interfaces for the Module
        config.requiredInterfaces = new bytes4[](1);
        config.requiredInterfaces[0] = 0x00000001;

        // register the intallation callback
        config.registerInstallationCallback = true;
    }

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

    // Install and Uninstall Functions

    function onInstall(bytes calldata data) external {
        uint256 step = abi.decode(data, (uint256));
        _counterStorage().step = step;
    }

    function onUninstall(bytes calldata data) external {}

    function encodeBytesOnUninstall() external pure returns (bytes memory) {
        return "";
    }
}
