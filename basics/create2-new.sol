// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract D {
    uint256 public number;

    constructor(uint256 num) {
        number = num;
    }
}

contract Create2 {
    function getBytes32(uint256 salt) external pure returns (bytes32) {
        return bytes32(salt);
    }

    function getAddress(bytes32 salt, uint256 arg)
        external
        view
        returns (address)
    {
        address add = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xff),
                            address(this),
                            salt,
                            keccak256(
                                abi.encodePacked(type(D).creationCode, arg)
                            )
                        )
                    )
                )
            )
        );
        return add;
    }

    address public deployedAddress;

    function createContract(bytes32 salt, uint256 arg) public {
        D d = new D{salt: salt}(arg);
        deployedAddress = address(d);
    }
}
