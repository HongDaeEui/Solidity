// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

// import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
import "https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/VRFConsumerBase.sol";

/**
 * THIS IS AN EXAMPLE CONTRACT WHICH USES HARDCODED VALUES FOR CLARITY.
 * PLEASE DO NOT USE THIS CODE IN PRODUCTION.
 */
contract RandomNumberConsumer is VRFConsumerBase {
    
    bytes32 internal keyHash;
    uint256 internal fee;
    
    mapping(bytes32 => uint256) public requestIdToRequestNumberIndex;
    uint256 public requestCounter;
    mapping(bytes32 => uint256) public requestIdToRandomNumber;
    
    mapping(address => uint) public order;
    
    address vrfowner;
     
    mapping(uint => radper_chk) public randomResult_chk;
    
    struct radper_chk{
        uint requestNumber;
        bool chk;
        uint256 randomResult;
    }

    
    /**
     * Constructor inherits VRFConsumerBase
     * 
     * Network: Kovan
     * Chainlink VRF Coordinator address: 0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9
     * LINK token address:                0xa36085F69e2889c224210F603D836748e7dC0088
     * Key Hash: 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4
     */
    constructor() 
        VRFConsumerBase(
            0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B, // VRF Coordinator
            0x01BE23585060835E02B77ef475b0Cc51aA1e0709  // LINK Token
        ) public
    {
        keyHash = 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311;
        fee = 0.1 * 10 ** 18; // 0.1 LINK (Varies by network)
        vrfowner = msg.sender;
    }

    /** 
     * Requests randomness 
     */
    function getRandomNumber() public returns (bytes32 requestId) {
    require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK - fill contract with faucet");
    vrfowner= msg.sender;
    bytes32 requestId =  requestRandomness(keyHash, fee);
    requestIdToRequestNumberIndex[requestId] = requestCounter;
    order[msg.sender] = requestCounter;
    requestCounter += 1;
   
    
    }

    /**
     * Callback function used by VRF Coordinator
     */
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        requestIdToRandomNumber[requestId] = (randomness % 50) + 1;
        uint256 requestNumber = requestIdToRequestNumberIndex[requestId];
        randomResult_chk[requestNumber].randomResult = requestIdToRandomNumber[requestId];
        randomResult_chk[requestNumber].requestNumber = requestIdToRequestNumberIndex[requestId];
        
    }

    // function withdrawLink() external {} - Implement a withdraw function to avoid locking your LINK in the contract
}