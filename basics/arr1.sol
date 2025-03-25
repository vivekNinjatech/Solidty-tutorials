// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TestArrays {
    uint256[] arr1;

    uint256[][] arr2;
    uint256[][] arr3 = [[1, 2], [2, 3]];

    function insert(uint256 value) public returns (uint256) {
        arr1.push(value);
        return arr1.length;
    }

    function insertMultiD(uint256[] memory val) external returns (uint256) {
        arr2.push(val);
        return arr2.length;
    }

    function getArr1() public view returns(uint256[] memory){
        return arr1;
    }

    function getArr2() public view returns (uint256[][] memory) {
        return arr2;
    }

    function getArr3() public view returns (uint256[][] memory) {
        return arr3;
    }

    
}
