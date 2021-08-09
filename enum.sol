pragma solidity 0.8.6;

contract Enum {
    enum Results { A, B, C }
    Results X   = Results.A;
    Results Y = Results.B;
    Results Z  = Results.C;
    
    mapping(address => Results) ResultMap;
    
    function test() public view returns (Results){
        return X;
    }
    
    function test1(uint _num) public returns (bool){
        ResultMap[msg.sender] = Results(0); 
        return ResultMap[msg.sender] == Results(_num);
    }
    //enum을 비교할 때에 enum의 배열값을 비교한다. 
}