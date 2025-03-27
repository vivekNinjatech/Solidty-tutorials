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


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 309 gas
contract Cons {
    uint16 public constant pie = 314;
}

// 2443 gas
contract Cons2 {
    uint16 public pie = 314;
}

contract Errors {
    // gas refunded, state updates are reverted
    // use csutom errors to save gas

    // * require
    // used to validate inputs and for access controll, controll who gets to call the function
    function testRequire(uint256 value) public pure {
        require(1 == value, "It's incorrect");
    }

    // * revert
    // better option if the checking is under lots of if statements
    function testRevert() public pure {
        if (1 == 1) {
            revert("It's a lie");
        }
    }

    // * assert
    // used to check condition that should always be true,
    // if the condition gets false that means there's a bug in your smart contract
    bool flag = false;

    function testAssert(bool check) public view {
        assert(flag == check);
    }

    function makeSwitch() public {
        flag = !flag;
    }




    // custom error
    error CustomError(uint, address);
    function throwCustomError(uint256 intVal, address add) public pure {
        revert CustomError(intVal, add);
    }
}
