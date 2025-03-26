// // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// contract Additional {
//     function testUnderflow()public pure returns(uint){
//         uint x = 0;
//         x--;
//         return x;
//     }

//     function testUnderflow2()public pure returns(uint){
//         uint x = 0;
//         {x--;}
//         return x;
//     }
// }

error Unauthorized(address caller);

contract CustomError {
    address payable owner = payable(msg.sender);

    function withdraw() public {
        if (msg.sender != owner) {
            // given approach consumes lots of gas
            revert("You do not have the right to withdraw");
        }
        owner.transfer(address(this).balance);
    }

    function withdraw2() public {
        if (msg.sender != owner) {
            // this approach consumes less gas
            revert Unauthorized(msg.sender);
        }
        owner.transfer(address(this).balance);
    }
}

// functions outside of the contract
function sayHello() pure returns (string memory) {
    return "Hello";
}
