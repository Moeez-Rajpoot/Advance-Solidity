// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SimpleStorage {

    uint256 myFavNumber;

    struct Person {
        string name;
        uint256 age;
    }

    Person[] public PersonList ;
    mapping (string => uint256) public PersonAge;

    function addFavnumber(uint256 _myFavNumber) public  {
        myFavNumber = _myFavNumber;
    
    }
     
    function retrive() public view returns(uint256) {
        return myFavNumber;
    }

    function addPerson(string memory _name ,uint256 _age) public  {

        Person memory newPerson = Person({name:_name, age : _age });
        PersonAge[_name] = _age ;
        PersonList.push(newPerson);
    }

    
}