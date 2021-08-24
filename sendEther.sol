pragma solidity 0.8.6;

contract sendther {
    
    constructor() payable {
    }
    
    
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    
    function sendEther(address _address) public {
    require(address(this).balance >= 0);
    payable(_address).transfer(0.1 ether);     
    }
    
    function donate() public payable {
        
    }
    
    fallback() external payable {
        
    }
}