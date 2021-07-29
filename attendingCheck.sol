pragma solidity 0.8.6;

contract attendingCheck {
    
    struct Student {
        string name;
    }
    
    Student[] students;
    
    mapping(address => uint) count;
    mapping(address => string) name;
    
    address owner;
    
    
    constructor() {
        count[msg.sender] = 1;
        name[msg.sender] = "HanSooYoung";
        owner = msg.sender;
    }
    
    
    function addName(string memory _name) public {
    name[msg.sender] = _name;
    }
    
    function attending(string memory _name) public {
    require( count[msg.sender] == 0);
    count[msg.sender] = 1;
    students.push(Student(_name));
    }
    
    function LookUp() public view returns(Student[] memory) {
    return students;
    }
}
    