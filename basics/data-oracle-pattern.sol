// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract SomeOracleCallback {
    function oracleCallback(
        int256 _value,
        uint256 _time,
        bytes32 info
    ) external virtual;
}

contract SomeOracle {
    SomeOracleCallback[] public callbacks; // array of all subscribers

    // Register subscriber
    function addSubscriber(SomeOracleCallback a) public {
        callbacks.push(a);
    }

    // Notify all subscribers
    function notify(
        int256 value,
        uint256 time,
        bytes32 info
    ) private {
        for (uint256 i = 0; i < callbacks.length; i++) {
            // all called subscribers must implement the oracleCallback
            callbacks[i].oracleCallback(value, time, info);
        }
    }

    function doSomething() public {
        // Example values for demonstration
        int256 _value = 42; // Replace with actual value logic
        uint256 _time = block.timestamp; // Current block timestamp
        bytes32 _info = keccak256(abi.encodePacked("Example Info")); // Replace with meaningful info

        // Notify all subscribers with data
        notify(_value, _time, _info);
    }
}
