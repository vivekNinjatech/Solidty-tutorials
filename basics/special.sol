// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FunctionAssignment {
    // Function that doubles the input
    function a(uint256 x) public pure returns (uint256) {
        return x * 2;
    }

    // Assign function to a variable
    function useFunction() public pure returns (uint256) {
        // Declare the function type explicitly
        function(uint256) pure returns (uint256) f = a;

        // Call the function through the variable
        return f(22); // Returns 44
    }

    function retTup() public pure returns (uint256, uint256) {
        return (1, 2);
    }

    function resTup() public pure returns (uint256, uint256) {
        uint256 x;
        uint256 y;
        (x, y) = retTup();
        return (x, y);
    }

    // ENUMS
    enum Day {
        Sun,
        Mon,
        Tue,
        Wed,
        Thu,
        Fri,
        Sat
    }

    function retDay(Day day, address user) public view returns (uint256) {
        address(this);
        user.balance;
        return uint256(Day(day));
    }

    function returnTwoVals() public pure returns (uint256, uint256) {
        return (1, 2);
    }

    function catchTwoVals() public pure returns (uint256, uint256) {
        (uint256 aa, uint256 bb) = returnTwoVals();
        return (aa, bb);
    }

    // Functions hoisted - and can assign a function to a variable
    function aaa() public view returns (uint256) {
        function() view returns (uint256) z = b;
        return z();
    }

    function b() public pure returns (uint256) {
        return 3;
    }
}
