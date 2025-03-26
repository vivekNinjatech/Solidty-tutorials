// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Contract to be deployed
contract SimpleContract {
    uint256 public value;
    constructor(uint256 _value) {
        value = _value;
    }
}

// Factory contract using CREATE2
contract Factory {
    event ContractDeployed(address contractAddress);
    address public newContractAddress;

    function deploy(bytes32 salt, uint256 _value) public returns (address) {
        // Deploy the contract using CREATE2
        address deployedAddress;
        bytes memory bytecode = abi.encodePacked(
            type(SimpleContract).creationCode,
            abi.encode(_value) // Pass constructor arguments
        );

        assembly {
            deployedAddress := create2(
                0, // No Ether sent
                add(bytecode, 0x20), // Start of the bytecode
                mload(bytecode), // Length of the bytecode
                salt // Deterministic salt
            )
            if iszero(deployedAddress) {
                revert(0, 0)
            }
        }

        emit ContractDeployed(deployedAddress);
        newContractAddress = deployedAddress;
        return deployedAddress;
    }

    function computeAddress(bytes32 salt, uint256 _value) public view returns (address) {
        // Compute the address using CREATE2 formula
        bytes memory bytecode = abi.encodePacked(
            type(SimpleContract).creationCode,
            abi.encode(_value) // Pass same constructor argument
        );

        return address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xff), // Prefix for CREATE2
                            address(this), // Factory address
                            salt, // Salt
                            keccak256(bytecode) // Corrected Bytecode Hash
                        )
                    )
                )
            )
        );
    }
}
