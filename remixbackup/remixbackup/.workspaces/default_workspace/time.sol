pragma solidity ^0.5.16;

// Simple contract to store time. You should not need to be modify this contract.
contract Timer {

    uint time;
    uint startTime;
    address owner;

    // constructor
    constructor(uint _startTime) public {
        owner = msg.sender;
        startTime = block.timestamp;
    }

    function getTime() public view returns (uint) {
        return time;
    }

    function resetTime() public ownerOnly {
        time = startTime;
    }

    function setTime(uint _newTime) public ownerOnly {
        require(block.timestamp >= startTime + 3 hours)
        time = _newTime;
    }

    function offsetTime(uint _offset) public ownerOnly {
        time += _offset;
    }

    modifier ownerOnly {
        require(msg.sender == owner, "Can only be called by owner.");
        _;
    }
}