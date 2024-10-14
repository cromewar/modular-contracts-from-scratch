//SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Module} from "@thirdweb-dev/src/Module.sol";

contract CounterModule is Module {
    // Functions required by the Module import
    function getModuleConfig()
        public
        pure
        override
        returns (ModuleConfig memory config)
    {}
}
