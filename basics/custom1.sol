// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

contract ParentContract {
    function data() payable public returns (uint256) {
        return 8;
    }
}

contract ChildContract {
    ParentContract parentContract;

    function setContract(address addr) public {
        parentContract = ParentContract(addr);
    }

    function createNewContract() public {
        parentContract = new ParentContract();
    }

    function callFeed() public {
        parentContract.data{value: 10, gas: 30000}(); // Example: Adjust to 30000 gas units
    }
}
