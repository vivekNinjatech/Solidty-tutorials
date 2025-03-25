// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.29;

contract Destroyer {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function pay() public payable {
        require(msg.value > 1 ether, "Need more than 0.1 ETH");
    }

    // function destroyMe() public payable {
    //     selfdestruct(payable(msg.sender));
    // }

    function hashh(string memory amount, string memory secret)
        public
        pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(amount, secret));
    }
}
