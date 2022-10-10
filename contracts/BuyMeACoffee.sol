// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Deployed to Goerli at 0x3BA927845D92ba1B22a6412e338c4269D54cA61e

// Coding Challenge: make a function that gives owner the ability to change the owner (give ownership to another address) hint: might need a state variables
// Second challenge: make another button for Buying Larger coffee for like 0.003 ETH

contract BuyMeACoffee {
    // Event to emit when a Memo is created.
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // list of all memos received from friends.
    Memo[] memos;

    // Contract Deployer's Address
    address payable owner;

    // Deploy Logic
    constructor() {
        owner = payable(msg.sender);
    }

    function buyCoffee(string memory _name, string memory _message)
        public
        payable
    {
        require(msg.value > 0, "Can't buy coffee for free!");

        // Add the memo to storage
        memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        // Emit a log event when a new memo is created!
        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    /**
     * @dev send the entire balance stored in this contract to the owner
     */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /**
     * @dev fetches all stored memos
     */
    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }
}
