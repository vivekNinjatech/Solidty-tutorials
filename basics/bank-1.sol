//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.22;

contract DepositContract {
    address owner;

    mapping(address => uint256) balance;
    mapping(address => uint256) time;

    event LogDepositMade(address user, uint256 amount, uint256 time);

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable returns (uint256) {
        require(balance[msg.sender] + msg.value >= msg.value, "Overflow");
        balance[msg.sender] += msg.value;
        time[msg.sender] = block.timestamp;
        emit LogDepositMade(msg.sender, msg.value, block.timestamp);
        return balance[msg.sender];
    }

    function withdraw(address to, uint256 amount)
        external
        virtual
        returns (uint256)
    {
        require(amount <= balance[to], "Insufficient");
        require(
            block.timestamp >= 2 minutes + time[to],
            "2 minutes hasn't passed yet"
        );

        (bool sent, ) = payable(to).call{value: amount}("");
        require(sent, "Failed to send ethers");
        balance[to] -= amount;
        return balance[to];
    }

    function getBalance(address account) public view returns (uint256) {
        return balance[account];
    }

    function getTime(address account) public view returns (uint256) {
        return time[account];
    }
}

contract WithdrawContract {
    DepositContract public depositContract;

    constructor(address _depositContract) {
        depositContract = DepositContract(_depositContract);
    }

    function withdraw(uint256 amount) public returns (uint256) {
        return depositContract.withdraw(msg.sender, amount);
    }
}
